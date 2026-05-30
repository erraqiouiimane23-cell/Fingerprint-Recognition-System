import pandas as pd

df = pd.read_csv("dataset_info.csv")

print("Shape:", df.shape)
print(df.head())