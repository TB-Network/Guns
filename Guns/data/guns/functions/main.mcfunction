#しゃがんでいる人を構えモードにする
execute as @a[scores={sneak=1..},tag=have_gun] run effect give @s slowness 1 255 true
execute as @a[scores={sneak=0}] run effect clear @s slowness
scoreboard players set @a sneak 0
item replace entity @a[tag=have_gun,tag=m4a1,scores={sneak=1..}] weapon.mainhand with carrot_on_a_stick{display:{Name:'{"text":"M4A1","color":"gold","italic":false}'},CustomModelData:2,un:1,m4a1:1} 1
item replace entity @a[tag=have_gun,tag=m4a1,scores={sneak=0},tag=model2] weapon.mainhand with carrot_on_a_stick{display:{Name:'{"text":"M4A1","color":"gold","italic":false}'},CustomModelData:1,gun:1,m4a1:1} 1

#銃を持ってる人にhave_gunタグを付ける
tag @a[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{gun:1}}}] add have_gun
tag @a[nbt=!{SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{gun:1}}}] remove have_gun
#m4a1を持っている人にm4a1タグをつける
tag @a[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1}}}] add m4a1
tag @a[nbt=!{SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1}}}] remove m4a1
#m4a1を持っている人にm4a1タグをつける
tag @a[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1,CustomModelDate:2}}}] add Model2
tag @a[nbt=!{SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1,CustomModelDate:1}}}] remove Model2

#リロード
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1}}}] at @s run scoreboard players set @p ammo 30
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1}}}] at @s run function give:m4a1
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick",tag:{m4a1:1}}}] at @s run kill @s

#銃を発射する
scoreboard players set @a[scores={ammo=0}] click 0
scoreboard players set @a[scores={cooldown=1..}] click 0


execute as @a[tag=m4a1,scores={click=1..}] run scoreboard players set @s cooldown 2
execute as @a[tag=m4a1,scores={click=1..}] run playsound minecraft:entity.iron_golem.damage master @a ~ ~ ~ 1000 1.7
execute as @a[tag=m4a1,scores={click=1..}] run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1000 1.7
scoreboard players remove @a[scores={click=1..}] ammo 1
execute as @a[tag=have_gun,scores={click=1..}] at @s run summon minecraft:armor_stand ~ ~ ~ {NoGravity:1b,Marker:1b,Invisible:1b,Tags:["m4a1_pro"]}
execute as @e[type=armor_stand,tag=m4a1_pro] at @s run tp ^ ^ ^1.0
execute as @a[scores={click=1..}] at @s run tp @e[tag=m4a1_pro,limit=1,sort=nearest] ^ ^ ^1.7 ~ ~
#execute at @e[tag=m4a1_pro] run particle flame ~ ~1.5 ~ 0.1 0.1 0.1 0.02 5
scoreboard players set @a click 0
execute as @e[tag=m4a1_pro] at @s as @e[distance=..1.5,type=!armor_stand,limit=1] run damage @s 3
execute as @e[tag=m4a1_pro] at @s if entity @e[distance=..1.5,type=!armor_stand,limit=1] run kill @s
scoreboard players remove @a[scores={cooldown=1..}] cooldown 1
item replace entity @e[tag=m4a1_pro] armor.head with snowball
execute as @e[tag=m4a1_pro] run data merge entity @s {Small:1}



#謎
title @a[tag=m4a1] actionbar [{"score":{"name":"@p","objective":"ammo"},"font":"test-16"}]