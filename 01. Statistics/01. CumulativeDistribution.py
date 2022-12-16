def cdf(sample):
    sample_list = list(sample)
    size = len(sample_list)
    sample_list.sort()
    x = sample_list
    uniques, probs, counts, y = [], [], [], []
    for i in range(size):
        if sample_list[i] != sample_list[(i + 1) % size]:
            uniques.append(sample_list[i])
    for unique in uniques:
        count = sample_list.count(unique)
        probs.append(count / size)
        counts.append(count)
    for j in range(len(uniques)):
        step = probs[j] / counts[j]
        if j == 0:
            base = 0
            for k in range(counts[j]):
                y.append(round(base + step * (k + 1), 10))
        else:
            base = y[-1]
            for k in range(counts[j]):
                y.append(round(base + step * (k + 1), 10))
    return x, y
