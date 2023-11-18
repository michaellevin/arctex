# arctex
GUI application for analyzing data from sensors

## Usage
```python
from pyt import CSVAdapter

sample_10559 = "DATA/reg_1699095129404.csv"
sensor_analyzer = CSVAdapter(sample_10559)
print(sensor_analyzer)
pprint(sensor_analyzer.get_plot_data("thickness"))
sensor_analyzer.save_to_json("DATA/10559.json")
```