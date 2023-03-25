library (tidyverse)

#data visualization
#ggplot => grammar of graphic

#----------------------base R visualization---------------------
plot(mtcars$mpg, mtcars$hp, pch=16, col="grey")

boxplot(mtcars$mpg)

t1 <- table (mtcars$am) #สร้างตารางความถึ่
barplot(t1)

hist(mtcars$mpg)



#---------------------- ggplot -------------------------------
# get mtcars, mapping mpg into x-axis, create histogram, no. of bins (default at 30)
ggplot(data = mtcars, mapping = aes(x=mpg)) +
  geom_histogram(bins=10)

ggplot(data = mtcars, mapping = aes(x=mpg)) +
  geom_density()

ggplot(data = mtcars, mapping = aes(x=mpg)) +
  geom_freqpoly()


p1 <- ggplot(mtcars, aes(mpg)) +
  geom_histogram()

p2 <- ggplot(mtcars, aes(hp)) +
  geom_histogram(bins=10)

mtcars %>%
  filter (hp <=100) %>%
  count()

# approach01 summary table + geom_col()
#create chart with not number, then pipe into ggplot
mtcars %>%
  mutate (am = ifelse(am==0, "Auto", "Manual")) %>%
  count(am) %>%
  ggplot (aes(am,n)) + 
  geom_col()

# or
t2 <- mtcars %>%
  mutate (am = ifelse(am==0, "Auto", "Manual")) %>%
  count(am)
  ggplot (t2, aes(x=am,y=n)) + 
  geom_col()
  

# approach02 geom_bar
  mtcars <- mtcars %>%
    mutate (am = ifelse(am==0, "Auto", "Manual"))
  
  ggplot (mtcars,  aes(am))+
    geom_bar()
  
  
  
# two variable, numeric
# scatter plot
  
ggplot (mtcars, aes (x=hp, y=mpg)) +
  geom_point(col="red", size=5)



# ordinal factor
temp <- c("high", "med", "low", "high")
temp <- factor(temp, levels = c("low", "med", "high"), ordered = TRUE)


# categorical factor
gender <- c ("m", "f", "m")
gender <- factor(gender)


glimpse(diamonds)

# frequency table
diamonds %>%
  count(cut, color, clarity)

# sample
set.seed(42) #lock result of sample otherwise it will be changed every time
diamonds %>%
  sample_n(5)

# sample fraction 1 is all, 0.5 is half or 50%
diamonds %>%
  sample_frac(0.5)

#sample slice, specific line
diamonds %>%
  slice(1:5)

#relationship (pattern)
ggplot (diamonds %>% sample_n(5000), aes(carat, price)) +
  geom_point() +
  geom_smooth(method = "loess") + #method="lm" linear
  geom_rug() #indicate density in XY axis


#setting vs. mapping
ggplot (diamonds, aes(price)) +
  geom_histogram(bins=100, fill="#2585F9")

# setting คือการกำหนดลักษณะต่างๆ
ggplot (diamonds %>% sample_n(500),
        aes (carat, price))+
  geom_point (size=5, alpha=0.2, col="red")


# mapping คือการดึง col เข้าไปใน map ใน elementของ chart ใช้บ่อยๆคือ color, shape
ggplot (diamonds %>% sample_n(500),
        mapping = aes (carat, price, col=cut))+
  geom_point (size=5, alpha=0.5)

# mapping 
ggplot (diamonds %>% sample_n(500),
        mapping = aes (carat, price, col=cut, shape=cut))+
  geom_point (size=5, alpha=0.5)


#change theme
ggplot (diamonds %>% sample_n(500),
        mapping = aes (carat, price, col=cut))+
  geom_point (size=5, alpha=0.5) +
  theme_minimal() +
  labs (
    title = "Relationship between carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive releation",
    caption = "Datasource: diamonds ggplot2"
  ) +
  scale_color_brewer(type="qual", palette=1)



#map color scale with number
ggplot (mtcars, mapping=aes(hp, mpg, col=wt))+
  geom_point(size=5, alpha=0.7) +
  theme_minimal() +
  scale_color_gradient(low="gold", high="purple")


#facet
ggplot (diamonds %>% sample_n(5000), aes (carat,price))+
  geom_point(alpha=0.5)+
  geom_smooth(col="red", fill="gold")+
  theme_minimal()+
  facet_wrap(~cut, ncol=3)

ggplot (diamonds %>% sample_n(30000), aes (carat,price))+
  geom_point(alpha=0.3)+
  geom_smooth(col="red")+
  theme_minimal()+
  facet_wrap(cut ~ color)

#combine charts
library (patchwork)
library (ggplot2)

p1 <- qplot (mpg, data=mtcars, geom="histogram", bins=10)
p2 <- qplot (hp, mpg, data=mtcars, geom="point")
p3 <- qplot (hp, data=mtcars, geom="density")

# patchwork to manage charts
p1 + p2 + p3
(p1 + p2) /p3
