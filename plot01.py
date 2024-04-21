#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 19 11:14:47 2024

@author: cperezal
"""

#   =========================================================================
#
#
#
#
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sunpy.time import parse_time


#ur = '/Users/cperezal/Documents/M2M/CMEAnalysis_2018.txt'
ur = '/Users/cperezal/Documents/M2M/CMEAnalysis_edit.txt'
pd = pd.read_table(ur, delim_whitespace=True)
pd.columns = ['date2', 'lat', 'lon', 'rad', 'vel', 'dateI', 'catalog', 'a', 'b' ]

pd_icme_detected_time_num=parse_time(pd['date2']).plot_date

plt.plot_date(pd_icme_detected_time_num, pd['vel'], c='black', markersize=0.9)
plt.ylabel('Velocity [km/s]')
plt.xlabel('Year')
plt.ylim([0,3500])





