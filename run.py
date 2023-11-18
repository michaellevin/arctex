from pprint import pprint

from pyt import CSVAdapter

sample_10559 = "DATA/reg_1699095129404.csv"
sample_A = "DATA/SampleA.csv"

x = CSVAdapter(sample_10559)
print(x)
print(x.sensor_id)
# pprint(x.data)
pprint(x.get_plot_data("thickness"))
x.save_to_json("DATA/10559.json")
