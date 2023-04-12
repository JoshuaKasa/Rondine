<div align="center">
  <img src="https://user-images.githubusercontent.com/87675824/178853557-3705e67a-140e-40d6-8a2c-0d235d8df481.png" alt="Rondine Logo" style="width:300px;height:300px;">
</div>

# 🖊️ ***TO-DO***

- Object search: Search bar for searching objects to make them easier to find. Right now, the rondine menu for object searching is very full, and the objects are not ordered by alphabetical order or any other kind of ordering, making it hard to find objects when having too many. The object search bar would be an easy and intuitive way of finding objects and reduce the time wasted for it.
- ~~Performance monitor: A way to monitor the performance of your game, such as frame rate and memory usage, could help you identify areas that need optimization.~~
- ~States save / loading: The possibility of saving and loading game states to make it easier to debug certain states of the game and finding errors.~
- Keyboard shortcut customization: Allowing users to customize the keyboard shortcuts for Rondine's functions could improve workflow and make it easier to use.
- Remove the ability to copy and paste objects: Copy and paste was a feature only implemented for debugging and checking the menu functionalities. With the new abilities of Rondine it's pretty useless to have copy and pasting, since it can be easily made yourself.
Remoing the ability to copy and paste will reduce the size of the menu and leave space for more option, like save and load or performance monitor. 

# 🧾 ***RONDINE***

Rondine is a debug menu developed for helping debugging your games in the best way possible! 
What can Rondine do?

- Check every object variable in real time.
- Modify object variables.
- Create objects.
- Copy and paste objects.
- Delete objects.
- Has a very simple GUI and setup.
- Pretty customizable.
- Works with every project.
- Save and load game states.
- Checking the performance of your game with a graph.


# 💾 **Installation**

For installing Rondine into your project you have to download the file, then open it in a GameMaker Studio 2 window and go to:

```Tools -> Create Local Package -> Name it however you want```

Once you've created the package you can go into your own project and import it by:

```Tools -> Import Local Package -> Package name```

You then successfully imported Rondine into your project!

# 🪄 **In-game Usage**

![Screenshot (495)](https://user-images.githubusercontent.com/87675824/178866714-4480bb54-bff3-4c38-9dce-cf13d9e53c35.png)

As said before, Rondine has a lot of features, and this is how to use them all.

## Create Objects
Create objects with Rondine is very easy and straightforward, you just press the **Right mouse button** and then select **Create** and select
your desired object.
If you have more than 10 objects in your game you'll be able to scroll down the objects list using the **Mouse wheel**.

<p align="center">
  <img src="https://user-images.githubusercontent.com/87675824/178868522-b16be3f1-1362-48d1-b053-8523a6bbc1b3.gif" width = "100%">
</p>

## Delete Objects
For deleting objects you can just press your button for opening Rondine and then select **Delete** on your selected object.

<p align="center">
  <img src="https://user-images.githubusercontent.com/87675824/178868893-daaba9b9-93d7-45dc-9712-11a3b4163e56.gif" width="100%">
</p>

## Change Object Variables
Changing an object's variables is probably the less intuitive thing of Rondine, but once you know how to do it it's super easy!
You just select your object and then select **Variables** in the Rondine menu.
There you can see all of your object's variables (you can scroll down with the mouse wheel) and you can select one and change it 
however you want.

<img src = "https://user-images.githubusercontent.com/87675824/178868522-b16be3f1-1362-48d1-b053-8523a6bbc1b3.gif" width = "100%">

## Copying and Pasting Objects
Copying and pasting is very easy, you just select **Copy** on the object you want and then click **Paste**.
Note that the object will be created at the position of where you clicked **Paste**.

<img src = "https://user-images.githubusercontent.com/87675824/178869332-842b8034-5c34-46bd-bdab-3768c9d3a21b.gif" width = "100%">

## Inspecting Objects
Inspecting is pretty different from changing or checking object's variables.
In fact, with the inspection there's a set of pre-chosen variables that will show up on the top right, and will not be able to be changed.
For closing the inspection, either select **Back** in the Rondine menu or click on the little **X** in the top right of the inspection menu.

<img src = "https://user-images.githubusercontent.com/87675824/178872278-1559b84b-ef87-4c0b-a68e-e8ea0667f5c0.gif" width = "100%">

# 🪄 **Usage**
Once Rondine has been imported into your project, you can place the object `rondine_menu` inside your room.
Note that `rondine_menu` is a persistent object, this will make it exist in every room including and after the one you placed it in.
Also note that you could have potential GUI size problems, since Rondine resizes when it's created (you can always change it inside your code).

## Modify Aesthetic
Rondine is a versatile tool that can be modified however you want.
First off, the aesthetic... You can change the Rondine's aesthetic by going into:

```Rondine -> Functions -> rondine_menu_settings```

There you can find all of the Rondine's options, especially colors.

## Add Options
As said before, Rondine is very versatile, in fact, you can add various options and make them function as you want.
For adding an option you wanna go to:

```Rondine -> Objects -> rondine_menu -> Create Event```

Once in the create event you wanna go into the **options** array, and for adding a new option you want to:

![carbon](https://user-images.githubusercontent.com/87675824/178851638-0165cb94-1e26-4bdd-b8e6-4e123434404d.png)

This would be an example option:

![carbon (1)](https://user-images.githubusercontent.com/87675824/178851856-66fa8097-1ef0-4529-913a-e5ae8187f39e.png)


## Excluding Certain Objects
Rondine gives you the possibility of excluding certain objects that you don't want to inspect or debug.
For doing that you wanna go to:

```Rondine -> rondine_menu -> Go to the last line -> excluded_objects[] -> Object name + .id```

This is an example:

![carbon (2)](https://user-images.githubusercontent.com/87675824/178852721-542c84bb-72d3-42d2-8dbd-bd36b0f424c4.png)

Here I'm excluding the objects: **oPlayer, oCamera, oMouse** (remember that you must put `.id` at the end of each object name for this to work). 
