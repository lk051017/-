# 
# library(tidyverse)
# library(corrmorant) # 假设corrmorant包或您的绘图函数在这个包里
# 
# # 读取数据
# new_data <- read_csv("C:/Users/97830/Desktop/测试.csv")
# 
# # 选择您要分析的列，这里是DA001和225
# numdata <- new_data[, c("Pw-DA001", "Cems-2015")]
# 
# # 进阶绘图代码
# # 这里假设您已经定义了如lotri, utri_heatmap等函数，可能这些是corrmorant包的一部分
# p1 <- ggcorrm(numdata) +
#   lotri(geom_point(alpha = 0.5)) +
#   utri_heatmap(corr_method = "spearman", alpha = 0.5) +
#   utri_corrtext(corr_size = F, size = 5, corr_method = "spearman") +
#   dia_names(y_pos = 0.15, size = 3) +
#   dia_histogram() +
#   scale_fill_corr(option = "A") +
#   lotri(geom_smooth(method = "lm"))
# 
# 
# # 显示图形
# p1
# 
# 







# 
# 
# # install.packages("readxl")
# # install.packages("ggplot2")
# # install.packages("dplyr")
# 
# # 首先安装sunburstR包，如果还没有安装的话
# if (!require(sunburstR)) {
#   install.packages("sunburstR")
#   library(sunburstR)
# }
# 
# # 读取您的数据
# data <- read_excel("C:/Users/97830/Desktop/新建 Microsoft Excel 工作表 (2).xlsx")
# 
# # 转换数据为层次化结构
# # 请根据您的数据的实际情况调整下面的代码
# data_hierarchy <- data %>%
#   mutate(path = paste(所属源类1, 所属源类2, 所属源类3, sep = "-")) %>%
#   group_by(path) %>%
#   summarise(value = sum(SO2, na.rm = TRUE)) %>%
#   ungroup()
# 
# # 使用sunburstR绘制旭日图，包括路径作为标签
# sunburst(data_hierarchy, count = FALSE, legend = FALSE)




# # 加载必要的库
# library(readxl)
# library(dplyr)
# library(ggplot2)
# 
# # 读取数据
# file_path <- "C:/Users/97830/Desktop/新建 Microsoft Excel 工作表 (2).xlsx"
# data <- read_excel(file_path)
# 
# # 数据处理
# # 将数据按照所属源类2和所属源类3进行分组，并计算总的SO2排放量
# grouped_data <- data %>%
#   group_by(所属源类2, 所属源类3) %>%
#   summarise(SO2 = sum(SO2, na.rm = TRUE)) %>%
#   ungroup()
# 
# # 绘制堆积柱状图
# ggplot(grouped_data, aes(x = 所属源类2, y = SO2, fill = 所属源类3)) +
#   geom_bar(stat = "identity", position = "stack") +
#   theme_minimal() +
#   labs(title = "二氧化硫排放量堆积柱状图",
#        x = "所属源类2",
#        y = "二氧化硫排放量 (单位：可能是吨或千克)") +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1))
# 
# # 注意：确保所属源类2和所属源类3列的命名与实际数据文件中的列名一致


# 
# # 加载必要的库
# library(readxl)
# library(dplyr)
# library(ggplot2)
# library(forcats)
# 
# # 读取数据
# file_path <- "C:/Users/97830/Desktop/新建 Microsoft Excel 工作表 (2).xlsx"
# data <- read_excel(file_path)
# 
# # 数据处理
# # 首先转换所属源类2为因子并保持原始顺序
# data$所属源类2 <- factor(data$所属源类2, levels = unique(data$所属源类2))
# 
# # 将数据按照所属源类2和所属源类3进行分组，并计算总的SO2排放量
# grouped_data <- data %>%
#   group_by(所属源类2, 所属源类3) %>%
#   summarise(SO2 = sum(SO2, na.rm = TRUE)) %>%
#   ungroup()
# 
# # 绘制堆积柱状图
# ggplot(grouped_data, aes(x = 所属源类2, y = SO2, fill = 所属源类3)) +
#   geom_bar(stat = "identity", position = "stack") +
#   theme_minimal() +
#   labs(title = "二氧化硫排放量堆积柱状图",
#        x = "所属源类2",
#        y = "二氧化硫排放量 (单位：可能是吨或千克)") +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1))
# 
# # 注意：确保所属源类2和所属源类3列的命名与实际数据文件中的列名一致



library(RColorBrewer)
library(tidyverse)
library(readxl)

# 设置数据路径
data_path <- "C:/Users/97830/Desktop/新建 Microsoft Excel 工作表 (2).xlsx"

# 读取数据
data <- read_excel(data_path)

# 数据预处理
# 标记类别与子类别
data <- data %>%
  mutate(Subcategory = ifelse(is.na(所属源类3) | 所属源类3 == "", NA, 所属源类3),
         Category = 所属源类2)

# 创建因子变量以匹配 Excel 中的顺序
data$Category <- factor(data$Category, levels = unique(data$Category))

# 生成自定义颜色
custom_colors <- colorRampPalette(brewer.pal(8, "Set1"))(num_categories)

# 修改 ggplot 代码以使用自定义颜色
ggplot(data, aes(x = Category, y = SO2, fill = Subcategory)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = custom_colors) +
  labs(x = " ", y = "SO2排放量(t)", fill = " ", title = "") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(axis.text.x = element_text(size = 12), 
        axis.text.y = element_text(size = 12))

# 将图保存为SVG文件
ggsave("stacked_bar_chart.emf", width = 8, height = 6, device = "emf")


































