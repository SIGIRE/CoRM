# encoding: utf-8
class QuotationPdf < Prawn::Document
 
 include ActionView::Helpers::NumberHelper
 
  def initialize(quotation, view)
    super()
    
    @quotation = quotation
    
    @view = view
    
    
    quotation_template
    logo
    header
    customer
    mycompany
    tags
    total
    signature
    condition
    page
   
#pour repeter des headers et footers
=begin
    repeat :all do
    # header
      modele
      logo
      entete
      client
      masociete
    end
=end

  end
  
  

  def quotation_template
    text_box "#{@quotation.quotation_template.company} - #{@quotation.quotation_template.adress} - #{@quotation.quotation_template.zip} #{@quotation.quotation_template.city} - #{@quotation.quotation_template.country}
                Tél. : #{@quotation.quotation_template.tel} - Fax : #{@quotation.quotation_template.fax}
                Internet : #{@quotation.quotation_template.web} - E-Mail : #{@quotation.quotation_template.email}
                #{@quotation.quotation_template.capital}
                APE #{@quotation.quotation_template.ape} - TVA : #{@quotation.quotation_template.vat} - SIRET : #{@quotation.quotation_template.company_registration_number}",
      :size => 8,
      :align => :right,
      :at => [235,cursor],
      :width => 300,
      :height => 80
  end
  
  def logo
    if !@quotation.quotation_template.attach.nil?
      logo_path = @quotation.quotation_template.attach.path
      image(logo_path, :height => 80)
    end
  end
  
  def header
    text_box "DEVIS N° #{@quotation.id}", :size => 20, :style => :bold, :at => [0,600]
  end
  
  
  def customer
    
    move_down 10

    formatted_text_box [ { :text =>"#{@quotation.account.company unless @quotation.account.nil?} \n", :styles => [:bold], :size => 12},
                         { :text =>"#{@quotation.account.adress1 unless @quotation.account.nil?} \n", :size => 10},
                         { :text =>"#{@quotation.account.zip unless @quotation.account.nil?} #{@quotation.account.city unless @quotation.account.nil?}", :size => 10}
                       ],
    :at => [300,cursor], :width => 300, :height => 100
  end



  def mycompany
    #:header  => true
    #:position => :center
    #:width => 400 ?
    move_down 80
    
    if @quotation.contact.nil?
      table = make_table( [ ["Réf.", "Date", "Réf. Client", "Collaborateur"],
                          ["#{@quotation.ref}", "#{@quotation.date.strftime("%d/%m/%Y") unless @quotation.date.blank?}", "#{@quotation.ref_account}", "#{@quotation.user.full_name}"]
                        ])
    else
      table = make_table( [ ["Réf.", "Date", "Réf. Client", "Collaborateur", "Contact"],
                          ["#{@quotation.ref}", "#{@quotation.date.strftime("%d/%m/%Y") unless @quotation.date.blank?}", "#{@quotation.ref_account}", "#{@quotation.user.full_name}" ,"#{@quotation.contact.full_name}"]
                        ])
    end
    
    
    table.draw
  end



  def tags
    
    move_down 30
    
    
    data = [["Référence","Désignation","Qté","P.U HT","Total HT"]]
    
    lines = @quotation.quotation_lines.map do |line|
      [
        line.ref,
        line.designation,
        number_with_precision(line.quantity.to_s, :precision => 2) || 0,
        "#{line.price_excl_tax} €",
        "#{line.total_excl_tax} €"
      ]
    end
    
    
    data += lines
    
    
    table = make_table(data, :header => true,
        #:position => :center,
        :width => 535,
        :column_widths => [80,275,50,60,70],
        :cell_style => {:size => 10 }
        )
    
    #table.row(0).columns(0..4).background_color = "000000"
    table.columns(2).align = :center
    table.columns(3..4).align = :right
    
    table.cells.borders = []
    table.row(0).font_style = :bold
    
    table.columns(0..4).borders = [:right, :left]
     table.row(0).columns(0..4).borders = [:bottom, :right, :top, :left]
    
    table.row(-1).columns(0..4).borders = [:bottom, :right, :left]
    table.draw
     
    
  end
  
  
  
  def total
    
    move_down 30
    #text_box "Total HT \t\t #{@quotation.total_ht} € \n TVA #{@quotation.quotation_template.vat_rate}% \t\t #{@quotation.total_tva} € \n Total TTC \t\t #{@quotation.total_ttc} €\n"
    text_box "Total HT \n TVA #{@quotation.VAT_rate}% \n Total TTC",
      :style => :bold,
      :size => 12,
      :align => :left,
      :at => [360,cursor],
      :width => 200,
      :height => 100
      
    text_box "#{@quotation.total_excl_tax} € \n#{@quotation.total_VAT} € \n#{@quotation.total_incl_tax} €",
      :style => :bold,
      :size => 12,
      :align => :right,
      :at => [380,cursor],
      :width => 150,
      :height => 100
      
    
    stroke do
      rounded_rectangle [350, cursor+10], 185, 55, 10
    end
  end
  
  
  
  def page
    string = "Page <page> sur <total>"
    options = { :at => [bounds.right - 150, 0],
                :width => 150,
                :align => :right,
                :start_count_at => 1}
    number_pages string, options
  end
  
  
  
  def condition
    move_down 20
    validity = "Validité du devis :"
    if !@quotation.validity.blank?()
      validity += " #{@quotation.validity} jours" 
    end
    text_box validity,
      :align => :center,
      :at => [0,cursor],
      :width => 200,
      :height =>100
      
    move_down 30
    text_box "Conditions de règlement :",
      :style => :bold,
      :align => :center,
      :at => [0,cursor],
      :width => 200,
      :height =>100
      
    stroke do
      horizontal_line 25, 175, :at => cursor-13
    end
    
    move_down 20
    text_box "#{@quotation.mode_reg unless @quotation.mode_reg.blank?}",
      :align => :center,
      :at => [0,cursor],
      :width => 200,
      :height =>100  

  end
  
  
  
  def signature
    move_down 100
    text_box "Signature et cachet du client :",
      :align => :center,
      :style => :bold,
      :at => [250, cursor],
      :width => 200,
      :height => 100
      
    stroke do
      rounded_rectangle [250, cursor+10], 290, 125, 20
      horizontal_line 265, 435, :at => cursor-13
    end
  end
  
end

