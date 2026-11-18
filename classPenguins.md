
For example, if we have three species of penguins on four islands, that's twelve combinations.

If we do something like
activity ~ species + island, 

we have 3-1=2 parameters for species differences, and 4-1=3 parameters for island differences. Adding 1 for intercept is a total of 6

If we add the _interaction_:
activity ~ species * island, 
the number of parameters there is the product of the two contributing variables: 2×3=6.

Note that adding these all up gives twelve, the total number of combinations.
