# Developing algorithm for triage of abdominal pain using artificial intelligence 


## Dataset
- Data collection period : 2015.1 ~ 2020.1
- Target : All patients with abdominal pain who visited to the ED of military hospital


## Pre-processing

- Mecab: Open-source text segmentation library for morphological analyzer
- KoNLPy : Python package for natural language processing of the Korean language
- Py-hanspell : Korean spelling checker library for Python using Naver Spell Checker


## Modeling

- Machine learning models
  - Logistic regression, decision tree, XGboost, and multi-layer perceptron
  - Tabular data and text data were utilized
  - Text data was encoded using a counter vectorizer
- Deep neural network
  - Fully connected layer and GRU (Gated Recurrent Units) 
  - Tabular data and text data were utilized
  - Text data was encoded using the embedding layer
- Mixed model with prior medical knowledge
  - The best model, the XGboost model, combined with prior medical knowledge
  - The rules were depicted in code `3_machine_learning_models.ipynb`


## Set-up 
`sh ./install_requirements.sh`
