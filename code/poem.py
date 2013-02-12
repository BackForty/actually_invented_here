class TumblingHair:
  def picks(self, flower_type):
    return flower_type in [
        'buttercups',
        'violets',
        'dandelions'
        ]

class Flower:
  def bullies(self):
    return self == 'daisies'

class Field:
  def eyes(self):
    return ";("

  def pickers(self):
    return [TumblingHair()]

field = Field()
pickers = field.pickers()
picker = pickers[0]
print picker.picks("violets")
print(field.pickers())
