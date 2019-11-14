
import pandas as pd
import io
import matplotlib.pyplot as plt
import numpy as np
import datetime
from datetime import timedelta
from datetime import datetime
from matplotlib.patches import Rectangle
import matplotlib.patches as patches
import matplotlib.pyplot as plt
import matplotlib.patches as mpatch
import math

df1=pd.read_csv('output_part_2/dataplot_b/dataplot-DropTail-complete-latency.dat', sep=' ')
df2=pd.read_csv('output_part_2/dataplot_b/dataplot-RED-complete-latency.dat', sep=' ')

df1=df1.sort_values('time', ascending=True).reset_index()
df2=df2.sort_values('time', ascending=True).reset_index()

df1 = df1.groupby([df1['time']]).agg({'latency': np.average})
df1.to_csv("output_part_2/dataplot_b/dataplot-DropTail-avg-latency.dat", sep='\t')

df2 = df2.groupby([df2['time']]).agg({'latency': np.average})
df2.to_csv("output_part_2/dataplot_b/dataplot-RED-avg-latency.dat", sep='\t')

print("output at: \noutput_part_2/dataplot_b/dataplot-DropTail-avg-latency.dat\noutput_part_2/dataplot_b/dataplot-RED-avg-latency.dat")
