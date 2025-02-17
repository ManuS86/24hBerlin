//
//  Utils.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 28.01.25.
//

import Foundation

func checkPassword(_ password: String, _ confirmPassword: String) -> String? {
    guard password == confirmPassword else {
        return "passwords_do_not_match."
    }
    
    guard password.count >= 8 else {
        return "password_must_be_at_least_8_characters_long."
    }
    
    guard password.rangeOfCharacter(from: .decimalDigits) != nil else {
        return "password_must_contain_at_least_one_number."
    }
    
    guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
        return "password_must_contain_at_least_one_uppercase_letter."
    }
    
    let specialCharacters = CharacterSet(charactersIn: "!\"#$%&'()*+,-./:;<=>?@[]\\^_`{|}~")
    guard password.rangeOfCharacter(from: specialCharacters) != nil else {
        return "password_must_contain_at_least_one_special_character."
    }
    
    return nil
}
