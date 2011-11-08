describe '{{name}}', ->
  {{name}} = null
  
  beforeEach ->
    class {{name}} extends Spine.Model
      @configure '{{name}}'
  
  it 'can noop', ->
    