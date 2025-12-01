# ============================================
# Clean Violin Plot Script (with IQR filtering)
# Author: Zane
# ============================================

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# -------- USER INPUTS --------
data_path = "CN_data_for_violin_plot.csv"   # Path to your CSV
output_path = "CN_violin_plot_filtered.svg" # Output SVG file
title_text = "C/N Ratio Across Land Management Types (Outliers Removed)"
y_label = "C/N Ratio"

# Order of groups (consistent across all plots)
group_order = ['PA', 'CC', 'HF', 'WP', 'OC', 'TP']

# -------- OUTLIER REMOVAL FUNCTION --------
def remove_outliers_iqr(df):
    cleaned = pd.DataFrame()
    for group in df['Group'].unique():
        sub = df[df['Group'] == group]
        Q1 = sub['Value'].quantile(0.25)
        Q3 = sub['Value'].quantile(0.75)
        IQR = Q3 - Q1
        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR
        sub_clean = sub[(sub['Value'] >= lower_bound) & (sub['Value'] <= upper_bound)]
        cleaned = pd.concat([cleaned, sub_clean], ignore_index=True)
    return cleaned

# -------- LOAD & CLEAN DATA --------
df = pd.read_csv(data_path)
df_cleaned = remove_outliers_iqr(df)

# -------- CREATE VIOLIN PLOT --------
plt.figure(figsize=(10, 6))
sns.violinplot(
    data=df_cleaned,
    x="Group",
    y="Value",
    order=group_order,
    inner="box",
    palette="Set2",
    linewidth=1
)

plt.title(title_text, fontsize=13)
plt.ylabel(y_label)
plt.xlabel("")
sns.despine()

# -------- SAVE AS SVG --------
plt.savefig(output_path, format="svg", bbox_inches="tight", dpi=300)
plt.close()

print(f"Violin plot saved as: {output_path}")
