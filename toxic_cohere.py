import cohere

co = cohere.Client("R3iO8MGP8Pv5mDpjnognJVliWEEzg2yAI9Bxrbk9")

from cohere.classify import Example

examples = [
  Example("you are hot trash", "Toxic"),
  Example("go to hell", "Toxic"),
  Example("get rekt moron", "Toxic"),
  Example("get a brain and use it", "Toxic"),
  Example("say what you mean, you jerk.", "Toxic"),
  Example("Are you really this stupid", "Toxic"),
  Example("I will honestly kill you", "Toxic"),
  Example("I fucking hate you", "Toxic"),
  Example("stop being shit you cunt", "Toxic"),
  Example("goddamn you're an idiotic little motherfucker", "Toxic"),
  Example("bro how horny are you?", "Toxic"),
  Example("You're one load your mother should have swallowed.", "Toxic"),
  Example("yo how are you", "Benign"),
  Example("I'm curious, how did that happen", "Benign"),
  Example("Try that again", "Benign"),
  Example("Hello everyone, excited to be here", "Benign"),
  Example("I think I saw it first", "Benign"),
  Example("That is an interesting point", "Benign"),
  Example("I love this", "Benign"),
  Example("We should try that sometime", "Benign"),
  Example("You should go for it", "Benign"),
  Example("you are wrong, since i don't believe you are right", "Benign")

]

inputs = [
  "Your self-importance is hilariously tragic."
]

response = co.classify(
    model='medium',
    inputs=inputs,
    examples=examples)

print(response.classifications)
