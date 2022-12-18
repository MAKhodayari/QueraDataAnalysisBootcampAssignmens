import numpy as np
from scipy.stats import norm


states = list(map(int, input().split()))
margin = float(input())
p = 0.93
q = 1 - p
n = len(states)
mu = n * p
sigma = np.sqrt(n * p * q)
threshold = abs(norm.ppf((1 - margin) / 2))
lower = - threshold * sigma + mu
upper = threshold * sigma + mu
if lower < sum(states) < upper:
    print('ACCEPT')
else:
    print('REJECT')
