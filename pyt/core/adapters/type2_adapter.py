from datetime import datetime
from typing import Dict, List, override

from .base_adapter import BaseAdapter
from ..utils import extract_and_concatenate_numbers


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
        sensor_id = extract_and_concatenate_numbers(sensor_id)
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

            adapted_data[sensor_id][timestamp_str] = {
                "thickness": thickness,
                "temperature": temperature,
            }

        return adapted_data

    @override
    def datetime_from_str(date_string):
        date_object = datetime.strptime(date_string, "%Y-%m-%d %H:%M:%S")
        return date_object
