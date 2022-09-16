#' -----------------------------------
#' 
#' ggplot 2 intro with palmerpenguins
#' 
#' @date 2022-09-15
#' 
#' -----------------------------------

#### Libraries ####
library(ggplot2)
library(palmerpenguins)
library (visdat)
library (ggridges)
library (ggdist)

#### let's look at the data penguins ####
head(penguins)
str(penguins)
summary(penguins)
vis_dat(penguins)

# how to run a function from a library without loading it
# library_name::function()
visdat::vis_miss(penguins)

#### Our First ggplot! ####

bill_dist <- ggplot(data = penguins,
                    mapping = aes(x = bill_length_mm))

class(bill_dist)
str(bill_dist)

# look at our masterpiece!
bill_dist     # nothing there bc didn't tell R what to put on y-axis

# add a geom_() - specializing geometric objects on a plot
?geom_histogram
bill_dist + 
  geom_histogram()
bill_dist + 
  geom_histogram(bins = 40)

# Now you try geom_density. How’s it look?

bill_dist +
  geom_density()

# If you want, try adding arguments like fill, color, and alpha to geom_density() 
# if you want to get fancy.

# fill, color for outlines, alpha for transparency (0-1)
bill_dist +
  geom_density(fill = "blue", 
               alpha = 0.2)

#### Visualizing multiple distributions ####
bill_dist_byspecies <- ggplot(data = penguins,
                              mapping = aes(x = bill_length_mm,
                                            group = species))
bill_dist_byspecies +
  geom_density()

# add fill as an aesthetic
bill_dist_byspecies +
  geom_density(mapping = aes(fill = species),
               alpha = 0.5)

# arguements for positioning
bill_dist_byspecies +
  geom_density(mapping = aes(fill = species),
               alpha = 0.5,
               position = "stack")

# Now you try geom_histogram. How’s it look? Bad, right? 
bill_dist_byspecies +
  geom_histogram()

# Try different colors, alphas, and fills to see if you can improve. 
bill_dist_byspecies +
  geom_histogram(mapping = aes(fill = species),
                 alpha = 0.5)

# Maybe a different position? What works best?
bill_dist_byspecies +
  geom_histogram(mapping = aes(fill = species),
                 color = "navy",
                 alpha = 0.5,
                 bins = 20,
                 position = "identity")  

#### visualizing 2 dimensions in space ####
bill_dist_xy <- ggplot(data = penguins,
                       mapping = aes(x = bill_length_mm,
                                     y = species,
                                     color = species))
#geom_point
bill_dist_xy +
  geom_point()

bill_dist_xy +
  geom_point(size = 5, alpha = 0.1)

# JITTER
bill_dist_xy +
  geom_jitter(size = 3,
              alpha = 0.5) # much easier to see individual points

# 1. Try out the following geoms - geom_boxplot(), geom_violin(), stat_summary(). 
#     Which do you prefer?
bill_dist_xy +
  geom_boxplot()

bill_dist_xy +
  geom_violin()

bill_dist_xy +
  stat_summary()

# 2. Try adding multiple geoms together. Does order matter?
bill_dist_xy +
  geom_boxplot() + stat_summary()

bill_dist_xy +
  stat_summary() + geom_boxplot()

bill_dist_xy +
  geom_violin(alpha = 0) + 
  geom_jitter(alpha = 0.5)

# 3. Try out geom_density_ridges() from ggridges
bill_dist_xy +
  geom_density_ridges(fill = "mistyrose",
                      alpha = 0.5)

bill_dist_xy +
  geom_density_ridges(fill = "goldenrod",
                      alpha = 0.1) +
  geom_jitter(size =3,
              alpha =0.2)

# Try out ggdist and it's geoms https://mjskay.github.io/ggdist/ 
bill_dist_xy +
  stat_halfeye(aes(fill = species),
               alpha = 0.75) +
  stat_dots(side = "bottom",
            aes(fill = species),
            color = "black") 

bill_dist_xy +
  stat_slab(mapping = aes (fill = species),
            alpha = 0.4)

#' ---------------------------------------
#' 
#' ggplot 2 intro - lab
#' 
#' @date 09-16-2022
#' 
#' ---------------------------------------

# some packages have vignettes which will tell you more about it
vignette("gallery", package = "ggridges")   # cheese plot

# switch x and y axis
bill_dist_xy +
  geom_boxplot() + 
  coord_flip()

# with stat_summary() can put in mean, standard deviation, etc...

#### scatterplots ####

pen_mass_length <- 
  ggplot(data = penguins,
         mapping = aes(x = body_mass_g,
                       y = bill_length_mm,
                       color = species))
# basic scatterplot
pen_scatter <- pen_mass_length+
  geom_point(alpha = 0.6)

#### facet by a data property ####

pen_scatter +
  facet_wrap(vars(species))

pen_scatter +
  facet_wrap(vars(species, sex))


# 1. Given that we have the same species of penguin on different islands, 
# what do you see if you use facet_grid() with both island and species?
?facet_grid

pen_scatter +
  facet_grid(vars(island, species))

pen_scatter +
  facet_grid(vars(species, island))
  
# 2. Incorporate other faceting variables - sex, year, etc. 
# Or mix up what is a facet and what is a color. What do you learn?


ggplot(data = penguins,
         mapping = aes(x = body_mass_g,
                       y = bill_length_mm,
                       color = sex)) + 
  geom_point(alpha = 0.6) + 
  facet_grid(vars(species, island)) 

ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = body_mass_g)) + 
  geom_point(alpha = 0.6) + 
  facet_grid(vars(sex, species))


















