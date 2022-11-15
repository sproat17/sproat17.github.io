# p2.Edward.Sproat

# Project 1: The Elevator interface

## For a C:

### Elevator

The following elevator was found in Holden Hall on campus.

### Photo

![ss](https://user-images.githubusercontent.com/82000483/192877637-15fc2dda-aaa4-440a-adf9-ac7fcabc0bc1.jpg)

### Interface in Action
    
![user](https://user-images.githubusercontent.com/82000483/192877763-3402f978-270f-406e-b6b4-14187589efa9.gif)

### Issues

    - G floor is in the basement of the building
    - Unknown "V" floor
    - Floor 1 is at the ground level
    - Elevator skips "V" floor while traveling from "G" floor to 1st floor
    - Multiple open and close buttons
    - Buttons are not grouped together by function

### Pros and Cons

| Pros          | Cons          |
| ------------- |:-------------:|
| Full functionality   | Unkonwn floors | 
| Buttons ligned up clearly between "G" and 3rd floor     | Ungrouped buttons      | 
| Braille | Painting over "V" button     |  
| Feedback | Redundant buttons     |  

## For a B:

![skethc](https://user-images.githubusercontent.com/82000483/192679950-087571fe-69b0-4ff1-8fa3-b042fc6dfd46.jpg)


### Common Uses 
    - The main function of an elevator is to transport people between floors
    - This means that the floor buttons are the most important for passengers
    - Buttons to make the travel between floors faster are secondary
    - A button to communicate with an employee should hopefully never be used, however it important to have that functionality in case something does go wrong

### Sequence 
    - After a user it enters the elevator it is assumed they will press the button of the floor they wish to go to
    - They may or may not hit the door open of door close, depending on external circumstances
    - All users picked up along the way have the same options as the first user
    - If the elevator stops working the user will press the bell button to speak to an employee

### Design
    - The main floor buttons are in the center of the screen and ordered left to right
    - The less commonly used buttons are laid out clearly at the bottom of the screen
    - After a button is pressed a red light is displayed around the chosen button
    - There is a small LCD screen that displays the current floor
    - Due to the “L” button this elevator format will only work in a hotel or building with a previous knowledge of a lobby 

### Defense of Control Interface
    - A small amount of area between the commonly used buttons and less commonly used buttons
    - The lobby button replaces the first floor as it would be previously known that there is a lobby
    - The two button is the first numbered floor as it is the second story and one floor above the lobby

## For an A:

### Size and Design
The control interface is 500×750 pixels, small enough to fit on almost all touch screen devices and large enough to be seen clearly on 1920×1080 screen. The design of the interface closely follows the sketch from part B, aside from the fact that a star was added next to the "L" button. The star next to the "L" button signifies that the lobby is the main floor for entrance to the building, as there is no floor 1. The screenshot shows a user on floor 6 wishing to travel to the lobby.

![screen](https://user-images.githubusercontent.com/82000483/192677780-509300c8-057e-4172-ab52-1eee282a1e52.png)


    
### Interactive Design 

#### Handling Single Floors

The User enters on floor 6 and travels to the Lobby of the building. 

![single](https://user-images.githubusercontent.com/82000483/192678961-42b095cf-6144-4bb0-b7a9-34709b772016.gif)


#### Handling Multiple Floors

At least two users enter the elevator at the lobby level. One choses floor 4 and the other floor 5. As the elevator stops at floor 4 a person enters and choses floor 8. The elevator travels to floor 5 and then goes to floor 8. (Faster than would be safe)

![multiple](https://user-images.githubusercontent.com/82000483/192678979-915ec522-f0a7-4d4d-bc9f-b860ab6680b9.gif)


#### Handling Elevator Errors

The user enters the elevator at the lobby and wishes to go to the 4th floor, however as the screen shows the elevator does not go up. By pressing the emergency button a person would be dispatched to manually reset the elevator. The emergency button will stay lit up until it is manually rest.

![error](https://user-images.githubusercontent.com/82000483/192679427-7b4696da-2e24-4f0a-8a75-c44269e97690.gif)
