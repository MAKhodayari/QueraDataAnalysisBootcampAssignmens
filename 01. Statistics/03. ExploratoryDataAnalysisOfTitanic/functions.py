import numpy as np
import pandas as pd


def survival_chance(titanic_df,start_age,end_age):
    Survived = titanic_df.Survived.tolist()
    Ages = titanic_df.Age.tolist()
    Sex = titanic_df.Sex.tolist()
    survived_age, sex_age = [], []
    for i in range(len(Survived)):
        if start_age <= Ages[i] <= end_age:
            survived_age.append(Survived[i])
            sex_age.append(Sex[i])
    males, females = sex_age.count('male'), sex_age.count('female')
    sur_males, sur_females = 0, 0
    for j in range(len(survived_age)):
        if survived_age[j] == 1 and sex_age[j] == 'male':
            sur_males += 1
        elif survived_age[j] == 1 and sex_age[j] == 'female':
            sur_females += 1
    if males == 0:
        male_chance = -1
    else:
        male_chance = round(sur_males / males, 3)
    if females == 0:
        female_chance = -1
    else:
        female_chance = round(sur_females / females, 3)
    chance = {'male': male_chance, 'female': female_chance}
    return chance
