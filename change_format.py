import pandas as pd

df = pd.read_excel("D:\\Programming\\DEPI\\Assignments\\2 Mini Project\\Central_Superstore.xlsx")

df.to_csv("D:\\Programming\\DEPI\\Assignments\\2 Mini Project\\Central_Superstore.csv", index=False)