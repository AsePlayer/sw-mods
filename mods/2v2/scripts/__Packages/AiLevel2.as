class AiLevel2
{
     function AiLevel2()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.isCreateType = true;
          this.playerLastStand = false;
          this.lastCreateTime = 0;
          this.WrathnarAvalible = true;
     }
}
