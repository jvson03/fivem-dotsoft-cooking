Config = {}

-- The distance required for the 3D test to be created.
Config.Distance = 1.5

-- The keybind for using the stove. (https://docs.fivem.net/docs/game-references/controls/)
Config.Keybinds = 54 -- E

-- If you want to use normal ESX notifications set this to false
Config.UseOkOkNotify = true

-- Strings, edit these if you want to translate to another language.
Config.Strings = {
    EToCookStove = "~b~Press ~y~[E]~b~ to use the stove.",
    EToCookToaster = "~b~Press ~y~[E]~b~ to use the toaster.",
    EToCookMicro = "~b~Press ~y~[E]~b~ to use the microwave.",
    WrongIngredients = "You are missing some ingredients."
}

-- The stove objects. Use hash keys. (https://gtahash.ru/)
Config.StoveModels = {
    [-1781967271] = true -- prop_cooker_03
}

-- The toaster objects. Use hash keys. (https://gtahash.ru/)
Config.ToasterModels = {
    [1055533654] = true, -- prop_toaster_02
    [1697216212] = true -- prop_toaster_01
}

-- The microwaves objects. Use hash keys. (https://gtahash.ru/)
Config.MicroModels = {
    [1306960905] = true, -- prop_microwave_1
    [356462018] = true, -- prop_micro_04
    [1490269418] = true, -- prop_micro_01
    [1796594030] = true -- prop_micro_02
}

-- You can add new stove recipes by following the examples
Config.StoveRecipes = {
    {['recipe'] = 'Gourmet Burger', ['item'] ='gourmetburger', ['ingredients'] = {
        {['ingredient'] = 'Bread', ['amount'] = 1},
        {['ingredient'] = 'Tomato', ['amount'] = 1},
        {['ingredient'] = 'Lettuce', ['amount'] = 1},
        {['ingredient'] = 'Pickles', ['amount'] = 1},
        {['ingredient'] = 'Beef', ['amount'] = 1},
        {['ingredient'] = 'Cheddar Cheese', ['amount'] = 1}
    }},
    {['recipe'] = 'Vegan Burger', ['item'] ='veganburger', ['ingredients'] = {
        {['ingredient'] = 'Bread', ['amount'] = 1},
        {['ingredient'] = 'Tomato', ['amount'] = 1},
        {['ingredient'] = 'Lettuce', ['amount'] = 1},
        {['ingredient'] = 'Pickles', ['amount'] = 1},
        {['ingredient'] = 'Vpatty', ['amount'] = 1}
    }},
    {['recipe'] = 'Chicken Sandwich', ['item'] ='chickensand', ['ingredients'] = {
        {['ingredient'] = 'Bread', ['amount'] = 1},
        {['ingredient'] = 'Tomato', ['amount'] = 1},
        {['ingredient'] = 'Lettuce', ['amount'] = 1},
        {['ingredient'] = 'Pickles', ['amount'] = 1},
        {['ingredient'] = 'Mayo', ['amount'] = 1},
        {['ingredient'] = 'Chicken Breast', ['amount'] = 1},
        {['ingredient'] = 'Cheddar Cheese', ['amount'] = 1}
    }},
}

-- You can add new toaster recipes by following the examples
Config.ToasterRecipes = {
    {['recipe'] = 'Toasted Bread', ['item'] ='toastedbread', ['ingredients'] = {
        {['ingredient'] = 'Bread', ['amount'] = 1}
    }},
}

-- You can add new microwave recipes by following the examples
Config.MicroRecipes = {
    {['recipe'] = 'Peperoni Pizza', ['item'] ='peperonipizza', ['ingredients'] = {
        {['ingredient'] = 'Frozen Peperoni Pizza', ['amount'] = 1}
    }},
}

-- Add new ingredients in this list. You also have to insert the items in the database yourself.
Config.Items = {
    ['Tomato'] = 'tomato',
    ['Beef'] = 'beef',
    ['Bread'] = 'bread',
    ['Sausage'] = 'chickensausage',
    ['Lettuce'] = 'lettuce',
    ['Flour'] = 'flour',
    ['Potato'] = 'potato',
    ['Cheddar Cheese'] = 'cheddarcheese',
    ['Chicken Breast'] = 'chicken_breast1',
    ['Lobster Tails'] = 'lobstertails',
    ['Pickles'] = 'pickles',
    ['Vpatty'] = 'vpatty',
    ['Mayo'] = 'mayo',
    ['Frozen Peperoni Pizza'] = 'frozenpeperonipizza',
}