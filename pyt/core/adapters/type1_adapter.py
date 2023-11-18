from datetime import datetime
from typing import Dict, List, override

from .base_adapter import BaseAdapter


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
