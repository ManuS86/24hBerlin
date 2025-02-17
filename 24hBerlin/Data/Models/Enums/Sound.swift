//
//  Sounds.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 18.01.25.
//

import Foundation

enum Sound: String, CaseIterable, Identifiable {
    case allStylesOfDarkMusic = "All styles of dark music"
    case eighties = "80s"
    case alternative = "Alternative"
    case coldWave = "Cold Wave"
    case darkwave = "Darkwave"
    case deathrock = "Deathrock"
    case dreamPop = "Dream Pop"
    case ebm = "EBM"
    case electro = "Electro"
    case electroclash = "Electroclash"
    case experimental = "Experimental"
    case folk = "Folk"
    case gothicRock = "Gothic Rock"
    case hardcorePunk = "Hardcore Punk"
    case hiNRG = "Hi-NRG"
    case horrorPunk = "Horror Punk"
    case indie = "Indie"
    case industrial = "Industrial"
    case italoDisco = "Italo-Disco"
    case metal = "Metal"
    case minimal = "Minimal"
    case mittelalter = "Mittelalter"
    case ndw = "NDW"
    case neoFolk = "Neofolk"
    case newBeat = "New Beat"
    case newWave = "New Wave"
    case postPunk = "Post-Punk"
    case powerPop = "Power Pop"
    case psychobilly = "Psychobilly"
    case punk = "Punk"
    case rock = "Rock"
    case rockasbilly = "Rockabilly"
    case shoegaze = "Shoegaze"
    case singerSongwriter = "Singer/Songwriter"
    case ska = "Ska"
    case synthPop = "Synth-Pop"
    case techno = "Techno"
    case wave = "Wave"
    case worldMusic = "World Music"
    
    var id: String { rawValue }
}
