import numpy as np


def calc(last_days, k):
    l = np.mean(last_days)
    p = np.exp(-l) * np.power(l, k) / np.math.factorial(k)
    return p
