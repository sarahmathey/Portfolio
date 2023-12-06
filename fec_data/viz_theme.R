library(showtext)

hex <- list(
# from World Health Organizations DDL
  blue_base     =     "#008dc9",
  blue_strong   =     "#0f2d5b",
  blue_weak     =     "#90d3fb",
  black_base    =     "#000000",
  black_weak    =     "#595959",
  black_weakest =     "#cccccc",
  white_base    =     "#ffffff",
  white_weak    =     "#f7f7f7",
  cat_0_strong  =     "#cc850a",
  cat_0_text    =     "#754d06",
  cat_1_base    =     "#f26829", 
  cat_1_strong  =     "#e85130",
  cat_1_text    =     "#9a3709",
  cat_2_base    =     "#bd53bd",
  cat_2_text    =     "#8e2f8e",
  cat_3_base    =     "#6363c0", 
  cat_3_text    =     "#4b4baf",
  cat_4_base    =     "#008dc9",
  cat_4_text    =     "#245993",
  cat_5_base    =     "#40bf73",
  cat_5_strong  =     "#37a463",
  cat_5_text    =     "#1d6339",
  cat_99_base   =     "#cccccc",
  cat_99_strong =     "#878787",
  cat_99_text   =     "#595959",
  ab_midnight   =     "#1C2345",
  ab_marigold   =     "#FFA300",
  biden_dark_blue =   "#061737",
  biden_dark_blue_75 = "#445169",
  biden_dark_blue_25 = "#C1C5CD",
  biden_blue =         "#2058ba",
  biden_blue_75 = "#5882CB",
  biden_blue_25 = "#C7D5EE",
  biden_red = "#f23036",
  biden_red_75 = "#F56468",
  biden_red_25 = "#FCCBCD",
  biden_yellow = "#ffcc33",
  biden_yellow_75 ="#FFD966",
  biden_yellow_25 = "#FFF2CC")

blue_seq = c("#d7e6f3","#75b6d6","#0582bb","#0f2d5b")

red_seq = c("#f5dbd9","#f8908b","#da484a","#a00016")

red_blue_div = c("#a00016","#d9777d","#d6dae5","#53abd0","#0f2d5b")

sjm_theme <-function(x){
  theme(
    text               = element_text(color = hex$cat_99_text, family = "Arial"),
    legend.position    = "top",
    panel.grid.minor   = element_blank(), 
    axis.ticks         = element_blank(), 
    axis.line          = element_blank(), 
    axis.title.y       = element_text(face = "italic", color = hex$cat_99_text, vjust = 3, size = 9), 
    axis.title.x       = element_text(face = "italic", color = hex$cat_99_strong, vjust = -1.9, size = 9),
    panel.grid.major.x = element_line(color = hex$cat_99_base) ,
    panel.grid.major.y = element_line(color = hex$cat_99_base) , 
    plot.background    = element_rect(fill = "transparent") ,
    panel.background   = element_rect(fill = "transparent") ,
    legend.background  = element_rect(fill = "transparent") ,
    plot.title         = element_text(face = "bold", hjust = 0.5),
    plot.subtitle      = element_text(size = 9, margin = margin(9,0,9,0), hjust = 0.5),
    strip.background   = element_rect(fill = hex$white_base)
  )
}

