import logging
from typing import List, Dict

from .adapters import BaseAdapter, CSVStrategy
from .parser import CSVParser

logger = logging.getLogger(__name__)
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)
logger.setLevel(logging.DEBUG)


class CSVAdapter(BaseAdapter):
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
