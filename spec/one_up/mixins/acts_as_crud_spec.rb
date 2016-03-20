require "spec_helper"
require "one_up/mixins/acts_as_crud"

describe OneUp::Mixins::ActsAsCrud do
 Given(:acts_as_crud) { OneUp::Mixins::ActsAsCrud }
 Given(:test_class) { Struct.keyed(:attr1, :attr2).extend(acts_as_crud) }

  context "creating records" do
    When(:result) { test_class.create(attr1: 1, attr2: 2) }
    Then { result.attr1 == 1 }
    Then { result.attr2 == 2 }
  end

  context "records are added to a list of previously created records" do
    Given { test_class.delete_all }
    When(:result) { test_class.create(attr1: 1, attr2: 2) }
    Then { test_class.all.count == 1 }
    Then { test_class.all.first == result }
  end

  context "clearing the record list" do
    Given{ test_class.create(attr1: 1, attr2: 2) }
    When { test_class.delete_all }
    Then { test_class.all.empty? }
  end
end