import csv
import json
import logging
from abc import ABC, abstractmethod
from typing import List, Tuple, Dict, Any, override
from datetime import datetime

try:
    from .utils import extract_and_concatenate_numbers
except ImportError:
    from utils import extract_and_concatenate_numbers

logger = logging.getLogger(__name__)
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)
logger.setLevel(logging.DEBUG)


class FileParser(ABC):
    @abstractmethod
    def parse_file(self, file_path: str) -> List[Dict]:
        pass


class CSVParser(FileParser):
    @staticmethod
    @override
    def parse_file(file_path: str) -> List[Dict]:
        with open(file_path, newline="") as csvfile:
            reader = csv.DictReader(csvfile)
            return [row for row in reader]


class BaseAdapter(ABC):
    def __init__(self):
        self._sensor_id = None
        self._data = None

    @abstractmethod
    def adapt_data(self, raw_data: List[Dict]) -> Dict:
        # here we will get sensor_id and data attributes
        ...

    def get_plot_data(self, key: str, default_value: float = 0.0) -> Dict:
        """Returns a dictionary with timestamps as keys and values of the specified key as values

        i.e.: {'2023-10-14T10:00:00+00:00': 0.109068, ... }
        """
        if self._data is None:
            raise ValueError("No data to get plot data from")
        result = {}
        for timestamp, readings in sorted(self._data[self._sensor_id].items()):
            result[timestamp] = readings.get(key, default_value)
        return result

    def convert_to_json(self) -> str:
        if self._data is None:
            raise ValueError("No data to convert to JSON")
        return json.dumps(self._data, indent=4)

    def save_to_json(self, file_path: str):
        if self._data is None:
            raise ValueError("No data to convert to JSON")
        with open(file_path, "w", encoding="utf-8") as json_file:
            json.dump(self._data, json_file, ensure_ascii=False, indent=4)

    @staticmethod
    def datetime_from_str(self, date_string):
        ...

    @property
    def data(self) -> Dict:
        return self._data

    @property
    def sensor_id(self) -> str:
        return self._sensor_id

    def get_sensor_data(self):
        if self._data is None:
            raise ValueError("No data to get sensor data from")
        return self._data[self._sensor_id]

    def __repr__(self):
        if self._data is None:
            return "No data to represent"
        data = self.get_sensor_data()
        iterator = iter(data)
        first_key = next(iterator)
        first_item = data[first_key]
        second_key = next(iterator)
        second_item = data[second_key]
        # Getting the last item
        last_key = next(reversed(data))
        last_item = data[last_key]
        return f"Sensor id: {self._sensor_id},\nData:\n\t{first_key}: {first_item}\n\t{second_key}: {second_item}\n\t...\n\t{last_key}: {last_item}"


class CSVType1Adapter(BaseAdapter):
    """Adapter for Type 1 CSV data
    Format of data arrived:
    {
        'ClockPosition': 'Hour12',
        'CreatedAt': '10/17/2023 09:46:32 +00:00',
        'Id': '103849',
        'IsValueValid': 'True',
        'Koef': '1000000',
        'Name': '108911',
        'ProbeLife': '0.25',
        'ProbeThickness': '0.5',
        'SerialNumber': '10559',
        'SystemType': '',
        'Temperature': '0',
        'Timestamp': '10/14/2023 18:00:00 +00:00',
        'UpdatedAt': '10/17/2023 09:46:32 +00:00',
        'Value': '108911'
    }
    """

    @override
    def adapt_data(self, raw_data: List[Dict]) -> Dict:
        # Logic to transform Type 1 CSV data into the required JSON-like structure
        _sensor_id = raw_data[0]["SerialNumber"]
        koeff = float(raw_data[0]["Koef"])
        # timestamps = [CSVType1Adapter.datetime_from_str(row["Timestamp"]) for row in raw_data]
        # thicknesses = [float(row["Value"])/koeff for row in raw_data]
        # temperatures = [float(row["Temperature"]) for row in raw_data]

        sensor_id = raw_data[0]["SerialNumber"]
        adapted_data = {_sensor_id: {}}

        for row in raw_data:
            timestamp = CSVType1Adapter.datetime_from_str(row["Timestamp"])
            timestamp_str = timestamp.isoformat()

            thickness = float(row["Value"] if row["Value"] is not None else 0.0) / koeff
            temperature = float(
                row["Temperature"] if row["Temperature"] is not None else 0.0
            )

            adapted_data[_sensor_id][timestamp_str] = {
                "thickness": thickness,
                "temperature": temperature,
            }

        return adapted_data

    @override
    def datetime_from_str(date_string):
        date_object = datetime.strptime(date_string, "%m/%d/%Y %H:%M:%S %z")
        return date_object


class CSVType2Adapter(BaseAdapter):
    """Adapter for Type 2 CSV data
    Format of data arrived:
    {
        "0000_Qual": "",
        "0000_Serial": "",
        "0000_Temp [C]": "",
        "0000_Thick [Ð¼Ð¼]": "",
        "0002_Qual": "",
        "0002_Serial": "",
        "0002_Temp [C]": "",
        "0002_Thick [Ð¼Ð¼]": "",
        "0004_Qual": "4",
        "0004_Serial": "2019-02297",
        "0004_Temp [C]": "41",
        "0004_Thick [Ð¼Ð¼]": "7.82936",
        "Ambient Temp [C]": "null",
        "Battery [V]": "null",
        "Instrument Name": "new instrument (Tryba 108 tryboprov 39)",
        "Timestamp UTC": "2023-09-08 12:08:39",
    }
    """

    @override
    def adapt_data(self, raw_data: List[Dict]) -> Dict:
        # Logic to transform Type 2 CSV data into the required JSON-like structure
        sensor_id = raw_data[0]["Instrument Name"]
        _sensor_id = extract_and_concatenate_numbers(sensor_id)
        # timestamps = [CSVType1Adapter.datetime_from_str(row["Timestamp UTC"]) for row in data]
        # thicknesses = [float(row["0004_Thick [Ð¼Ð¼]"])/koeff for row in data]
        # temperatures = [float(row["0004_Temp [C]"]) for row in data]
        adapted_data = {sensor_id: {}}

        for row in raw_data:
            timestamp = CSVType2Adapter.datetime_from_str(row["Timestamp UTC"])
            timestamp_str = timestamp.isoformat()

            thickness = (
                float(row["0004_Thick [Ð¼Ð¼]"]) if row["0004_Thick [Ð¼Ð¼]"] else 0.0
            )
            temperature = float(row["0004_Temp [C]"]) if row["0004_Temp [C]"] else 0.0

            adapted_data[_sensor_id][timestamp_str] = {
                "thickness": thickness,
                "temperature": temperature,
            }

        return adapted_data

    @override
    def datetime_from_str(date_string):
        date_object = datetime.strptime(date_string, "%Y-%m-%d %H:%M:%S")
        return date_object


class CSVStrategy:
    @staticmethod
    def get_strategy(raw_data: List[Dict]) -> BaseAdapter:
        if "ClockPosition" in raw_data[0].keys():
            return CSVType1Adapter()
        elif "Instrument Name" in raw_data[0].keys():
            return CSVType2Adapter()
        else:
            raise ValueError("Unknown sensor type")


class CSVAnalyzer(BaseAdapter):
    def __init__(self, file_path: str):
        super().__init__()
        self.file_path = file_path
        raw_dict_data = CSVParser.parse_file(file_path)  # Store raw data
        self._adapter = CSVStrategy.get_strategy(raw_dict_data)
        self._data = self.adapt_data(raw_dict_data)
        self._sensor_id = next(iter(self._data))

    def adapt_data(self, raw_data: List[Dict]) -> Dict:
        return self._adapter.adapt_data(raw_data)

    def get_plot_data(self, key: str, default_value: float = 0.0) -> Dict:
        return super().get_plot_data(key, default_value)

    def save_to_json(self, file_path: str) -> None:
        return super().save_to_json(file_path)


if __name__ == "__main__":
    from pprint import pprint

    sample_10559 = "DATA/reg_1699095129404.csv"
    sample_A = "DATA/SampleA.csv"
    # parsed_dict1 = CSVParser.parse_file(sample_10559)
    # parsed_dict2 = CSVParser.parse_file(sample_A)
    # data1 = CSVType1Adapter().adapt_data(parsed_dict1)
    # data2 = CSVType2Adapter().adapt_data(parsed_dict2)
    # logger.info(data2)
    x = CSVAnalyzer(sample_10559)
    print(x)
    # print(x.sensor_id)
    # pprint(x.data)
    pprint(x.get_plot_data("thickness"))
    # pprint(x.data)
    x.save_to_json("DATA/10559.json")
    # pprint(x.get_plot_data("thickness"))
