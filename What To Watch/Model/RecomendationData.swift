//
//  RecomendationData.swift
//  What To Watch
//
//  Created by Sean Ogden Power on 30/4/18.
//  Copyright © 2018 Sean Ogden Power. All rights reserved.
//

import Foundation

enum StreamName:String{
    case whedon = "Joss Whedon", jj = "JJ Abrams", comic = "Comic Book Hero"
}
enum TypeOfQuestion{
    case single,multiple,slider
}
enum Recomendation:String{
    case firefly = "Firefly", buffy = "Buffy the Vampire Slayer", avengers = "The Avengers", angel = "Angel", dochorrible = "Dr. Horrible's Sing-Along blog", cabin = "The Cabin in the Woods", muchado = "Much Ado About Nothing", starwars = "Star Wars", startrek = "Star Trek", super8 = "Super 8", lost = "LOST", alias = "ALIAS", spidey = "Spider-man", superman = "Man of Steel", batvsup = "Batman v Superman", ironman = "Iron Man", civilwar = "Captain America: Civil War", winter = "Captain America: Winter Soldier"
    
    var definition: String{
        switch self{
        case .firefly:
            return "Adventure - Five hundred years in the future, a renegade crew aboard a small spacecraft tries to survive as they travel the unknown parts of the galaxy and evade warring factions as well as authority agents out to get them."
        case .buffy:
            return "Buffy is a Slayer, one in a long line of young women chosen for a specific mission: to seek out and destroy vampires, demons and other forces of darkness. "
        case .avengers:
            return "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity."
        case .angel:
            return "The vampire Angel, cursed with a soul, moves to Los Angeles and aids people with supernatural-related problems while questing for his own redemption."
        case .dochorrible:
            return "Tells the story of Dr. Horrible, an aspiring supervillain, Captain Hammer, his superhero nemesis, and Penny, their mutual love interest. "
        case .cabin:
            return "Five friends go to a remote cabin in the woods. Bad things happen. If you think you know this story, think again."
        case .muchado:
            return "A modern retelling of Shakespeare's classic comedy about two pairs of lovers with different takes on romance and a way with words."
        case .startrek:
            return "The brash James T. Kirk tries to live up to his father's legacy with Mr. Spock keeping him in check as a vengeful Romulan from the future creates black holes to destroy the Federation one planet at a time"
        case .starwars:
            return "Stormtrooper defector Finn and the scavenger Rey are caught up in the Resistance's search for the missing Luke Skywalker"
        case .super8:
            return "During the summer of 1979, a group of friends witness a train crash and investigate subsequent unexplained events in their small town."
        case .lost:
            return "The survivors of a plane crash are forced to work together in order to survive on a seemingly deserted tropical island."
        case .alias:
            return "Sydney Bristow is an international spy recruited out of college, trained for espionage and self-defense."
        case.spidey:
            return "Peter Parker who, after being bitten by a genetically-altered spider, gains superhuman strength and the spider-like ability to cling to any surface vows to use his abilities to fight crime"
        case .superman:
            return "A young boy learns that he has extraordinary powers and is not of this Earth. As a young man, he journeys to discover where he came from and what he was sent here to do. But the hero in him must emerge if he is to save the world from annihilation and become the symbol of hope for all mankind"
        case .batvsup:
            return "Fearing the actions of a god-like super hero left unchecked, Gotham City’s own formidable, forceful vigilante takes on Metropolis’s most revered, modern-day savior, while the world wrestles with what sort of hero it really needs."
        case .ironman:
            return "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        case .winter:
            return "As Steve Rogers struggles to embrace his role in the modern world, he teams up with a fellow Avenger and S.H.I.E.L.D agent, Black Widow, to battle a new threat from history: an assassin known as the Winter Soldier."
        case .civilwar:
            return "It's Avengers vs. Avengers when Captain America fights to keep his superhero friends independent, while his pal Iron Man supports government control."
        }
    }
    var image: String{
        switch self{
        case .firefly:
            return "firefly"
        case .buffy:
            return "buffy"
        case .avengers:
            return "avengers"
        case .angel:
            return "angel"
        case .dochorrible:
            return "dochorrible"
        case .cabin:
            return "cabin"
        case .muchado:
            return "muchado"
        case .startrek:
            return "startrek"
        case .starwars:
            return "starwars"
        case .super8:
            return "super8"
        case .lost:
            return "lost"
        case .alias:
            return "alias"
        case.spidey:
            return "spidey"
        case .superman:
            return "supes"
        case .batvsup:
            return "bvs"
        case .ironman:
            return "ironman"
        case .winter:
            return "wintersoldier"
        case .civilwar:
            return "civilwar"
        }
    }
}
struct Question {
    var text: String
    var type: TypeOfQuestion
    var responses: [Response]
}

struct Response {
    var text:String
    var recomendation: [Recomendation]
}



//MARK: Class
//the RecomendationEngine is used to set up all the streams with their questions and answers etc and also to calcualte the results at the end.
class RecomendationEngine{
    var streams = [StreamName:[Question]]()
    var responses : [Response]!
    var currentQuestions: [Question]!
    var questionIndex = 0
    
    
    init(){
        //setup all the streams
        var tQuestion:Question
        //Whedon
        streams [.whedon] = [Question]()
        tQuestion = Question (text: "How much time do you have?", type: .single, responses: [
            Response(text: "< 2 hours", recomendation: [.dochorrible]),
            Response(text: "2-12 hours", recomendation: [.avengers, .muchado, .cabin]),
            Response(text: "> 12 hours", recomendation: [.buffy, .angel, .firefly])
            ])
        streams [.whedon]?.append(tQuestion)
        tQuestion = Question (text: "Select the Genres you like", type: .multiple, responses: [
            Response(text: "Romantic", recomendation: [.muchado]),
            Response(text: "Sci-Fi", recomendation: [.firefly,.dochorrible,.avengers]),
            Response(text: "Western", recomendation: [.firefly]),
            Response(text: "Horror", recomendation: [.cabin, .buffy, .angel])
            ])
        streams [.whedon]?.append(tQuestion)
        tQuestion = Question (text: "Do you like Super Heroes?", type: .slider, responses: [
            Response(text: "Not so much", recomendation: [.muchado, .firefly]),
            Response(text: "There's better", recomendation: [.cabin,.angel]),
            Response(text: "It's not bad", recomendation: [.buffy,.dochorrible]),
            Response(text: "Hell Yes!", recomendation: [.avengers])
            ])
        streams [.whedon]?.append(tQuestion)
        tQuestion = Question (text: "Do you like Shakespeare?", type: .single, responses: [
            Response(text: "Aye", recomendation: [.muchado]),
            Response(text: "Nay", recomendation: [.cabin])
            ])
        streams [.whedon]?.append(tQuestion)
        tQuestion = Question (text: "Select your favourite actors", type: .multiple, responses: [
            Response(text: "Nathan Fillion", recomendation: [.firefly]),
            Response(text: "Chris Hemsworth", recomendation: [.avengers]),
            Response(text: "Sarah Michelle Gellar", recomendation: [.buffy,.angel]),
            Response(text: "Clark Greg", recomendation: [.muchado,]),
            Response(text: "Scarlett Johansson", recomendation: [.avengers])
            ])
        streams [.whedon]?.append(tQuestion)
        tQuestion = Question (text: "Do you prefer witty dialogue or action?", type: .slider, responses: [
            Response(text: "Witty Dialogue", recomendation: [.muchado, .dochorrible]),
            Response(text: "A bit more on the witty", recomendation: [.cabin]),
            Response(text: "Right down the middle", recomendation: [.buffy, .angel]),
            Response(text: "Lean towards the action", recomendation: [.firefly]),
            Response(text: "Action", recomendation: [.avengers])
            ])
        streams [.whedon]?.append(tQuestion)
        tQuestion = Question (text: "When a main character dies you ...", type: .single, responses: [
            Response(text: "Turn off the tv in disgust", recomendation: [.avengers]),
            Response(text: "Laugh maniacly", recomendation: [.dochorrible, .cabin]),
            Response(text: "Cry into your popcorn", recomendation: [.buffy, .firefly]),
            ])
        streams [.whedon]?.append(tQuestion)
        //JJ
        streams [.jj] = [Question]()
        tQuestion = Question (text: "Which do you prefer?", type: .slider, responses: [
            Response(text: "Star Wars", recomendation: [.starwars]),
            Response(text: "Star Trek", recomendation: [.startrek])
            ])
        streams [.jj]?.append(tQuestion)
        tQuestion = Question (text: "Pick a genre", type: .single, responses: [
            Response(text: "Sci-Fi", recomendation: [.starwars, .startrek]),
            Response(text: "Monster", recomendation: [.super8, .lost]),
            Response(text: "Mystery", recomendation: [.lost, .alias]),
            Response(text: "Thriller", recomendation: [.alias])
            ])
        streams [.jj]?.append(tQuestion)
        tQuestion = Question (text: "Select your favourite actors", type: .multiple, responses: [
            Response(text: "Harrison Ford", recomendation: [.starwars]),
            Response(text: "Jennifer Garner", recomendation: [.alias]),
            Response(text: "Chris Pine", recomendation: [.startrek]),
            Response(text: "Evangeline Lilly", recomendation: [.lost]),
            ])
        streams [.jj]?.append(tQuestion)
        tQuestion = Question (text: "Pick a composor", type: .single, responses: [
            Response(text: "Michael Giacchino", recomendation: [.lost, .alias, .startrek, .super8]),
            Response(text: "John Williams", recomendation: [.starwars]),
            Response(text: "Chris Tilton", recomendation: [.alias]),
            ])
        streams [.jj]?.append(tQuestion)
        tQuestion = Question (text: "How much time do you have?", type: .slider, responses: [
            Response(text: "2 hours", recomendation: [.super8]),
            Response(text: "3-4 hours", recomendation: [.starwars, .startrek]),
            Response(text: "> 24 hours", recomendation: [.lost, .alias])
            ])
        streams [.jj]?.append(tQuestion)
        tQuestion = Question (text: "Pick the streaming services you have access to", type: .multiple, responses: [
            Response(text: "Netflix", recomendation: [.starwars]),
            Response(text: "Stan", recomendation: [.lost]),
            Response(text: "iTunes", recomendation: [.startrek]),
            Response(text: "Amzon Prime", recomendation: [.alias, .super8]),
            ])
        streams [.jj]?.append(tQuestion)
        tQuestion = Question (text: "Do you like strong female characters", type: .single, responses: [
            Response(text: "Yes", recomendation: [.starwars,.alias]),
            Response(text: "I don't mind", recomendation: [.lost]),
            Response(text: "No so much", recomendation: [.startrek, .super8])
            ])
        streams [.jj]?.append(tQuestion)
        
        //comic
        streams [.comic] = [Question]()
        tQuestion = Question (text: "Which do you prefer?", type: .slider, responses: [
            Response(text: "Marvel", recomendation: [.avengers,.civilwar,.ironman,.winter,.spidey]),
            Response(text: "DC", recomendation: [.batvsup,.superman])
            ])
        streams [.comic]?.append(tQuestion)
        tQuestion = Question (text: "Select your favourite actors", type: .multiple, responses: [
            Response(text: "Toby Maguire", recomendation: [.spidey]),
            Response(text: "Ben Affleck", recomendation: [.batvsup]),
            Response(text: "Amy Adams", recomendation: [.superman,.batvsup]),
            Response(text: "Samuel L Jackson", recomendation: [.avengers, .winter]),
            Response(text: "Scarlett Johansson", recomendation: [.avengers, .winter, .civilwar])
            ])
        streams [.comic]?.append(tQuestion)
        tQuestion = Question (text: "Comic movies should be ...", type: .single, responses: [
            Response(text: "Dark and Humourless", recomendation: [.batvsup]),
            Response(text: "Origin stories", recomendation: [.spidey, .superman, .ironman]),
            Response(text: "Full of mystery", recomendation: [.winter]),
            Response(text: "With Hero against Hero", recomendation: [.civilwar, .batvsup]),
            Response(text: "About saving the world", recomendation: [.avengers])
            ])
        streams [.comic]?.append(tQuestion)
        tQuestion = Question (text: "Pick composors you like", type: .multiple, responses: [
            Response(text: "Alan Silvestri", recomendation: [.avengers]),
            Response(text: "Danny Elfman", recomendation: [.spidey]),
            Response(text: "Hans Zimmer", recomendation: [.superman]),
            Response(text: "Henry Jackman", recomendation: [.winter, .civilwar]),
            Response(text: "Junkie XL", recomendation: [.batvsup])
            ])
        streams [.comic]?.append(tQuestion)
        tQuestion = Question (text: "Which do like your heroes to be more human or godlike", type: .slider, responses: [
            Response(text: "Human", recomendation: [.ironman,.winter]),
            Response(text: "More human", recomendation: [.spidey]),
            Response(text: "Both", recomendation: [.civilwar]),
            Response(text: "More godlike", recomendation: [.batvsup]),
            Response(text: "Godlike", recomendation: [.superman])
            ])
        streams [.comic]?.append(tQuestion)
        tQuestion = Question (text: "Do you like to see a villain thats ...", type: .single, responses: [
            Response(text: "Strong but stupid", recomendation: [.batvsup]),
            Response(text: "Looking for vengance", recomendation: [.spidey, .superman]),
            Response(text: "Formally a freind", recomendation: [.avengers, .winter, .civilwar])
            ])
        streams [.comic]?.append(tQuestion)
        tQuestion = Question (text: "Do you read comics", type: .single, responses: [
            Response(text: "Religiously", recomendation: [.spidey, .civilwar, .winter]),
            Response(text: "Once in a while", recomendation: [.superman]),
            Response(text: "They're for kids", recomendation: [.batvsup])
            ])
        streams [.comic]?.append(tQuestion)
    }
    
    func shuffle<T>(_ array:[T]) -> [T] {
        //create a copy of the input array
        var items = array
        
        //our new shuffled array
        var shuffled = [T]();
        
        //iterate through the item array
        for _ in items.enumerated()
        {
            //choose a random number
            let rand = Int(arc4random_uniform(UInt32(items.count)))
            //using that random number, select a random item
            let randomItem = items[rand]
            //append that random item to our new shuffled array
            shuffled.append(randomItem)
            //make sure to remove that item, so we don't pick it again
            items.remove(at: rand)
        }
        return shuffled
    }
    
    func setupQuiz (for stream: StreamName){
        //randomise the questions from the stream
        if let questions = streams[stream] {
            currentQuestions = shuffle (questions)
        }
        responses = [Response]()
        questionIndex = 0
    }
    
    func getNextQuestion ()->Question?{
        if currentQuestions.count > questionIndex {
            let nextQ = currentQuestions[questionIndex]
            questionIndex+=1
            return nextQ
        }
        return nil
    }
    
    func calculateResult ()->[(key: Double, value: Recomendation)]{
        var recs : [Double:Recomendation] = [:]
        let recomendations = responses.map {$0.recomendation}
        var scores = [Recomendation: Int]()
        var totCount = 0.0
        
        for recArray in recomendations{
            totCount += Double(recArray.count)
            //recArray is an array so we loop through all the vals in that
            for rec in recArray{
                scores [rec] = (scores[rec] ?? 0) + 1
            }
        }
        
        //get them sorted and then we'll return the top 3 (as long as they have a value)
        let scoreSorted = scores.sorted(by: {
            (pair1,pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        for rec in scoreSorted{
            var percent:Double = (Double(rec.value)/(totCount - Double (scoreSorted.count))) * 100.0
            
            //i dont want to over write ones of the same percentage
            while recs.index(forKey: percent) != nil{
                percent -= 0.001
            }
            
           recs[percent] = rec.key
            
            
            if recs.count == 3{
                break;
            }
            
        }
        let recsSorted = recs.sorted(by:{
            (pair1,pair2) -> Bool in
            return pair1.key > pair2.key
        })
        return recsSorted
    }
    
    
}
