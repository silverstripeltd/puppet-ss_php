require "spec_helper"

describe "ensure_php_packages" do
    it "creates a resource in the catalogue" do
      is_expected.to run.with_params(["mbstring", "gd"], ["5.6", "7.1"])
      expect(catalogue).to contain_package("php5.6-mbstring").with_ensure("present")
      expect(catalogue).to contain_package("php7.1-mbstring").with_ensure("present")
      expect(catalogue).to contain_package("php5.6-gd").with_ensure("present")
      expect(catalogue).to contain_package("php7.1-gd").with_ensure("present")
    end
    it "can ensure absent resource in the catalog" do
      is_expected.to run.with_params(["mbstring", "gd"], ["5.6", "7.1"], { "ensure" => "absent" })
      expect(catalogue).to contain_package("php5.6-mbstring").with_ensure("absent")
      expect(catalogue).to contain_package("php7.1-mbstring").with_ensure("absent")
      expect(catalogue).to contain_package("php5.6-gd").with_ensure("absent")
      expect(catalogue).to contain_package("php7.1-gd").with_ensure("absent")
    end
end
