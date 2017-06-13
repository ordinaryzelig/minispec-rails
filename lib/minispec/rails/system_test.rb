# We can't lazy load SystemTestCase, so we need to require this manually.
# If we can get Rails to add `run_load_hooks` for this class,
# then we can lazy load it and move it with the others in lib/minispec/rails.
ActionDispatch::SystemTestCase.extend(
  Module.new do
    def inherited(*)
      super
      unless Minitest::Spec::TYPES.find { |matcher, type| type == ApplicationSystemTestCase }
        Minitest::Spec.register_spec_type(//, ApplicationSystemTestCase)
      end
    end
  end
)
