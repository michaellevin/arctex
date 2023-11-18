from typing import List, Dict
from .type1_adapter import CSVType1Adapter
from .type2_adapter import CSVType2Adapter
from .base_adapter import BaseAdapter


class CSVStrategy:
    @staticmethod
    def get_strategy(raw_data: List[Dict]) -> BaseAdapter:
        if "ClockPosition" in raw_data[0].keys():
            return CSVType1Adapter()
        elif "Instrument Name" in raw_data[0].keys():
            return CSVType2Adapter()
        else:
            raise ValueError("Unknown sensor type")
