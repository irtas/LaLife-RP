local langName = {
  common = {
    loaded = "Lang laoded",
    access = "Accéder"
  },
  menu = {
    mainmenu = {
      title = "",
      tel = "Tel: ",
      police = "Menu Police",
      anim = "Animations",
      reper = "Répertoire",
      givecash = "Donner de l'argent",
      givedcash = "Donner de l'argent sale",
      inventory = "Inventaire",
      quantity = "Quantité : "
    },
    police = {
      title = "Menu Police"
    }
  }
}

AddEventHandler("getLang", function(callback)
  callback(langName)
end)
