//
//  ViewController.swift
//  WebServiceXML
//
//  Created by Rafael Luiz on 03/09/14.
//  Copyright (c) 2014 MouseTela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    var parser: NSXMLParser = NSXMLParser()
    
    var dadosXML: [ConteudoXML] = []
    
    var xmlTitulo: String = String()
    
    var xmlConteudo: String = String()
    
    var tagAtual: String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url:NSURL = NSURL(string: "http://mousetela.com.br/webservice/xml.php")
        
        parser = NSXMLParser(contentsOfURL: url)
        
        parser.delegate = self
        
        parser.parse()
        
        lerXML()
        
        
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        
        tagAtual = elementName
        
    }
    
    
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (!data.isEmpty) {
            
            if tagAtual == "titulo" {
                
                xmlTitulo += data
                
            } else if tagAtual == "conteudo" {
                
                xmlConteudo += data
                
            }
            
        }
        
    }
    
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if elementName == "conteudo" {
            
            let conteudoXML: ConteudoXML = ConteudoXML()
            
            conteudoXML.xmlTitulo = xmlTitulo
            
            conteudoXML.xmlConteudo = xmlConteudo
            
            xmlConteudo = String()
            xmlTitulo = String()
            
            dadosXML.append(conteudoXML)
            
        }
        
    }
    
    func lerXML(){
        
        for item in dadosXML{
           
            println("Titulo \(item.xmlTitulo)")
            println("Conteudo: \(item.xmlConteudo)")
            
        }
    }
    

}

