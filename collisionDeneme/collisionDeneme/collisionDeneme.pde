
int indexObj = -1;
for (int i = 0 ; i < gameObj.size(); i++) 
   {
     if(player.y >= gameObj.get(i).h &&
        player.x >= gameObj.get(i).x &&
        player.x + player.w <= gameObj.get(i).x + gameObj.get(i).w
        )
        {
          indexObj = i;
          break;
        }
   }
   
   if(indexObj != -1) //bir nesnenin üstündeyse
   {
     player.y = gameObj.get(indexObj).h; //objenin yukseklik sinirina inecek ama direkt degil, azalan hizda.. Ya da bu kouslda min player.y degeri obj.h kadar olabilir gibi bi kontrol yapilabilir
   }
   else //nesnenin üstünde degilse
   {
     player.y = height/4; //ilk yukseklik sinirina(initial) inecek ama direkt degil, azalan hizda..
   }