# encoding: utf-8
class DevisPdf < Prawn::Document
 
 include ActionView::Helpers::NumberHelper
 
  def initialize(devi, view)
    super()
    
    @devi = devi
    
    @view = view
    
    
    modele
    logo
    entete
    client
    masociete
    produits
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
  
  

  def modele
    text_box "#{@devi.modele.societe} - #{@devi.modele.adresse} - #{@devi.modele.cp} #{@devi.modele.ville} - #{@devi.modele.pays}
                Tél. : #{@devi.modele.tel} - Fax : #{@devi.modele.fax}
                Internet : #{@devi.modele.site} - E-Mail : #{@devi.modele.email}
                #{@devi.modele.capital}
                APE #{@devi.modele.ape} - TVA : #{@devi.modele.tva} - SIRET : #{@devi.modele.siret}",
      :size => 8,
      :align => :right,
      :at => [235,cursor],
      :width => 300,
      :height => 80
  end
  
  def logo
    logopath = @devi.modele.fichier_joint.path # "#{Rails.root}/app/assets/images/logo-sigire.png"
    image logopath #, :width => 80, :height => 80
  end
  
  def entete
      text_box "DEVIS N° #{@devi.id}", :size => 20, :style => :bold, :at => [0,600]
  end
  
  
  def client
    
    move_down 10

    formatted_text_box [ { :text =>"#{@devi.compte.societe} \n", :styles => [:bold], :size => 12},
                         { :text =>"#{@devi.compte.adresse1} \n", :size => 10},
                         { :text =>"#{@devi.compte.cp} #{@devi.compte.ville}", :size => 10}
                       ],
    :at => [300,cursor], :width => 300, :height => 100
  end



  def masociete
    #:header  => true
    #:position => :center
    #:width => 400 ?
    move_down 80
    
    if @devi.contact.nil?
      table = make_table( [ ["Numéro", "Date", "Réf. Client", "Collaborateur"],
                          ["#{@devi.ref}", "#{@devi.date.strftime("%d/%m/%Y")}", "#{@devi.ref_compte}", "#{@devi.user.nom_complet}"]
                        ])
    else
      table = make_table( [ ["Numéro", "Date", "Réf. Client", "Collaborateur", "Contact"],
                          ["#{@devi.ref}", "#{@devi.date.strftime("%d/%m/%Y")}", "#{@devi.ref_compte}", "#{@devi.user.nom_complet}" ,"#{@devi.contact.nom_complet}"]
                        ])
    end
    
    
    table.draw
  end



  def produits
    
    move_down 30
    
    
    data = [["Référence","Désignation","Qté","P.U HT","Total HT"]]
    
    items = @devi.items.map do |item|
      [
        item.ref,
        item.designation,
        number_with_precision(item.quantite.to_s, :precision => 2) || 0,
        "#{item.prix_ht} €",
        "#{item.total_ht} €"
      ]
    end
    
    
    data += items
    
    
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
    #text_box "Total HT \t\t #{@devi.total_ht} € \n TVA 19,60 % \t\t #{@devi.total_tva} € \n Total TTC \t\t #{@devi.total_ttc} €\n",
    text_box "Total HT \n TVA 19,60 % \n Total TTC",
      :style => :bold,
      :size => 12,
      :align => :left,
      :at => [360,cursor],
      :width => 200,
      :height => 100
      
    text_box "#{@devi.total_ht} € \n#{@devi.total_tva} € \n#{@devi.total_ttc} €",
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
    text_box "Validité du devis : #{@devi.validite} jours",
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
    text_box "#{@devi.mode_reg}",
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

