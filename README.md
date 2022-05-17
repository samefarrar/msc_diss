# MSC Dissertation

## The effect of antimicrobial resistance on the epidemiology and pathogenicity of vaccine-evading pneumococci

Streptococcus pneumoniae is a nasopharyngeal commensal and respiratory pathogen that is the most common cause of communityacquired pneumonia. It also causes other invasive diseases, such as sepsis and meningitis. 
It was recently estimated to be amongst the 6 most important species contributing to the mortality caused by antibiotic resistance. 

As a result, many countries invest in anti-pneumococcal polysaccharide conjugate vaccines (PCV) for infants. However, the manufacture of these vaccines is complex and therefore expensive and so they only cover a small proportion of serotypes (~ capsule types) of the pneumococcus. 

Hence, PCV's effectiveness at removing the serotypes they target is partially undermined by the expanision of other serotypes that are unaffected by the immunity induced by these vaccines.

## 12F *Streptococcus pneumoniae*

One of the most important "non-vaccine" serotypes is 12F. This is referred to as an "epidemic" serotype because of its highly invasive nature and ability to cause outbreaks of disease.
12F is also associated with multiple antibiotic resistance phenotypes, making the disease difficult to treat.

Following the introduction of the 13-valent PCV in 2010, many countries saw an increase in 12F disease, peaking aorund 2017-2018. This peak has since declined in Europe, the UK and South Africa and the reasons for this are not clear.

<img width="634" alt="image" src="https://user-images.githubusercontent.com/67292186/168802472-dfb884c9-85a4-44fb-bb59-67e453faff2d.png">


### Hypotheses for decline in 12F disease

1. 12F Isolates are being removed from carriage through naturally acquired immunity or competition with other strains
2. 12F Isolates are still present in carriage, but are causing disease at a reduced rate.
    *  Previous analysis using invasiveness modelling and NFDS has suggested that antibiotic resistant 12F is associated with lower invasiveness.

## Research Question

> Why has there been a decline in 12F disease since it's peak in 2017-2018?

**Hypothesis 1** : Decline in 12F disease in the UK represents the expansion of low-invasiveness antibiotic resistant genotype

## Aims

1. Generate a whole genome alignment of serotype 12F strains using surveillance and research data
     * TRIMMOMATIC
     * SPADES
2. Construct a phylogeny and identify variation in patterns of recombination and accessory genome content
     * GUBBINS for recombination
     * Panaroo for accessory genome content
3. Use machine learning approaches to predict antibiotic resistance phenotypes (from?) *and possibly validate these in the laboratory*. 
     * specific techniques to be explored
4. Use phylodynamic methods to fit a molecular clock and estimate the population size of the 12F genotypes and relate this to the observed incidence of 12F disease.
     * BactDating for population size
     * SkyGrowth to relate to observed incidence
     
     If decline in disease reflects a decline in carriage, then we should observe a significant relationship between the effective population size and incidence of disease (as determined by SkyGrowth).
     However, if the decline in disease reflects reduced invasiveness, we should see differing trends in the population size, depending on whether we select resistant or sensitive 12F isolates.
