import json
from abc import ABC, abstractmethod
from typing import List, Dict, Any, override

from ..utils import extract_and_concatenate_numbers


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
