require "soogem/soosv"
require "test/unit"
require 'tempfile'

class TestSooSV < Test::Unit::TestCase
   
  def setup
    @sample_header = "Name,Definition\r\n"
    @attributes = ["ACNTBL_BAL","\"ACCOUNTABLE BALANCE.  The dollar amount held by VBA which is\n\n associated with a PTCPNT, or unknown person(s).  This is established\n\n as a result of a returned check, amounts pending fiduciary\n\n identification or approval prior to release, Personal Funds Of\n\n Patients (PFOP), recurring payments calculated monthly but released\n\n other than monthly, payments due less than the established amount\n\n ($5) which are not to be released until additional funds are due,\n\n unassociated returned checks with no existing PTCPNT information,\n\n unassociated funds from PTCPNT which exceed RECEIVABLE balances and\n\n unassociated funds from anyone being held for research purposes.<br>\"","\"third attribute\"","fourth attribute\r\n"]
    @sample_line = @attributes.join(',')
    @csv_file = Tempfile.new(['fake', '.csv'])
    @csv_file.write(@sample_header)
    @csv_file.write(@sample_line)
    @csv_file.close

    @soosv = SooSV.new(@csv_file.path)
    @soosv.new_line_char = "\r\n"
    @soosv.get_lines
  end

  def teardown
    @csv_file.unlink
  end

  def test_setup
    @csv_file.open
    assert_equal(@sample_header, @csv_file.gets)
  end

  def test_initialize
    soosv = SooSV.new(@csv_file.path)
    assert_instance_of(SooSV, soosv)
  end

  def test_get_lines
    # nothing atm
  end

  def test_parse_header
    assert_equal(@sample_header, @soosv.header)
  end

  def test_parse_line
    assert_equal(@sample_line, @soosv.body.first)
  end

  def test_quote_toggles?
    simple_line = "foo\\\"bar. lol--+==234\\f"
    true_index = 4
    simple_line.chars.each_with_index do |char, index|
      eval_to = (index == true_index) ? true : false
      assert_equal(eval_to, @soosv.send(:quote_toggles?, simple_line, index))
    end
  end

  def test_line_to_array
    @attributes.each_with_index do |attribute, index|
      assert_equal(attribute, @soosv.line_to_array(@soosv.body.first)[index])
    end
  end

end
