import csv
from abc import ABC, abstractmethod
from typing import List, Dict, Any, override


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


if __name__ == "__main__":
    from pprint import pprint

    sample_10559 = "DATA/reg_1699095129404.csv"
    sample_A = "DATA/SampleA.csv"
    parsed_dict1 = CSVParser.parse_file(sample_10559)
    parsed_dict2 = CSVParser.parse_file(sample_A)
    pprint(parsed_dict1)
    # data1 = CSVType1Adapter().adapt_data(parsed_dict1)
    # data2 = CSVType2Adapter().adapt_data(parsed_dict2)
    # logger.info(data2)
    # x = CSVAnalyzer(sample_10559)
    # print(x)
    # print(x.sensor_id)
    # pprint(x.data)
    # pprint(x.get_plot_data("thickness"))
    # pprint(x.data)
    # x.save_to_json("DATA/10559.json")
    # pprint(x.get_plot_data("thickness"))
