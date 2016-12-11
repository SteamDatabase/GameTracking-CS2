"resource\MatchSystem.360.res"
{
   Version 11

   ExperienceFormula
   {
      0 "min(numGames/70,7)+min(numGamesTotal/1000,3)"
      minvalue 0
      maxvalue 10
   }
   Skill0Formula
   {
      0 "max(0,min(lastValue,3200))"
      minvalue 0
      maxvalue 3200
   }
   Skill1Formula
   {
      0 "0"
      minvalue 0
      maxvalue 10
   }
   Skill2Formula
   {
      0 "0"
      minvalue 0
      maxvalue 10
   }
   Skill3Formula
   {
      0 "0"
      minvalue 0
      maxvalue 0
   }
   Skill4Formula
   {
      0 "0"
      minvalue 0
      maxvalue 0
   }
   AvgFormula
   {
      0 "0.95 * avgValue + 0.05 * newValue"
   }

   SearchPass0
   {
      LanguageCheck 0
      VersionCheck 1
      DifficultyCheck 1
      CampaignCheck 1
      MapDesired 1
      GameStateCheck 1
      PartyCheck 0
      TeamSelectCheck 0
      ExpCheck 1
      ExperienceRange 0
      Skill0Check 1
      Skill0Range 200
      Skill1Check 0
      Skill1Range 0
      Skill2Check 0
      Skill2Range 0
      Skill3Check 0
      Skill4Check 0
   }
   SearchPass1		[$X360]
   {
      LanguageCheck 0
      VersionCheck 1
      DifficultyCheck 1
      CampaignCheck 1
      MapDesired 1
      GameStateCheck 1
      PartyCheck 0
      TeamSelectCheck 0
      ExpCheck 1
      ExperienceRange 1
      Skill0Check 1
      Skill0Range 400
      Skill1Check 0
      Skill1Range 0
      Skill2Check 0
      Skill2Range 0
      Skill3Check 0
      Skill4Check 0
   }
   SearchPass2		[$X360]
   {
      LanguageCheck 0
      VersionCheck 1
      DifficultyCheck 1
      CampaignCheck 1
      MapDesired 1
      GameStateCheck 1
      PartyCheck 0
      TeamSelectCheck 0
      ExpCheck 0
	  ExperienceRange 0
      Skill0Check 1
      Skill0Range 800
      Skill1Check 0
      Skill1Range 0
      Skill2Check 0
      Skill2Range 0
      Skill3Check 0
      Skill3Range 0
      Skill4Check 0
      Skill4Range 0
   }
   SearchPass3		[$X360]
   {
      LanguageCheck 0
      VersionCheck 1
      DifficultyCheck 1
      CampaignCheck 1
      MapDesired 1
      GameStateCheck 1
      PartyCheck 0
      TeamSelectCheck 0
      ExpCheck 0
      Skill0Check 1
	  Skill0Range 1600
      Skill1Check 0
	  Skill1Range 0
      Skill2Check 0
      Skill2Range 0
      Skill3Check 0
	  Skill3Range 0
      Skill4Check 0
	  Skill4Range 0
   }
   SearchPass4		[$X360]
   {
      LanguageCheck 0
      VersionCheck 1
      DifficultyCheck 1
      CampaignCheck 1
      MapDesired 1
      GameStateCheck 0
      PartyCheck 0
      TeamSelectCheck 0
      ExpCheck 0
      Skill0Check 0
	  Skill0Range 0
      Skill1Check 0
	  Skill1Range 0
      Skill2Check 0
      Skill2Range 0
      Skill3Check 0
	  Skill3Range 0
      Skill4Check 0
	  Skill4Range 0
   }

   EMPTY
   {
      EMPTY
      {
         PartySize1 17
         PartySize2 36
         PartySize3 65
         PartySize4 114
         PartySize5 1033
         PartySize6 1002
         PartySize7 1051
      }
      PL_1
      {
         PartySize1 6
         PartySize2 25
         PartySize3 54
         PartySize4 103
         PartySize5 1012
         PartySize6 1061
         PartySize7 1010
      }
      PL_1_1
      {
         PartySize1 15
         PartySize2 14
         PartySize3 43
         PartySize4 92
         PartySize5 1071
         PartySize6 1030
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 25
         PartySize2 4
         PartySize3 33
         PartySize4 82
         PartySize5 1061
         PartySize6 1020
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 34
         PartySize2 13
         PartySize3 22
         PartySize4 71
         PartySize5 1040
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 44
         PartySize2 23
         PartySize3 12
         PartySize4 61
         PartySize5 1030
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 54
         PartySize2 33
         PartySize3 2
         PartySize4 51
         PartySize5 1010
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 63
         PartySize2 42
         PartySize3 11
         PartySize4 40
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 73
         PartySize2 52
         PartySize3 21
         PartySize4 30
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 83
         PartySize2 62
         PartySize3 31
         PartySize4 20
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 93
         PartySize2 72
         PartySize3 41
         PartySize4 10
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 103
         PartySize2 82
         PartySize3 51
         PartySize4 0
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_1
   {
      EMPTY
      {
         PartySize1 6
         PartySize2 25
         PartySize3 54
         PartySize4 103
         PartySize5 1012
         PartySize6 1041
         PartySize7 1010
      }
      PL_1
      {
         PartySize1 15
         PartySize2 44
         PartySize3 93
         PartySize4 1002
         PartySize5 1051
         PartySize6 1000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 4
         PartySize2 33
         PartySize3 82
         PartySize4 1061
         PartySize5 1020
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 14
         PartySize2 23
         PartySize3 72
         PartySize4 1051
         PartySize5 1010
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 23
         PartySize2 12
         PartySize3 61
         PartySize4 1030
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 33
         PartySize2 2
         PartySize3 51
         PartySize4 1020
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 43
         PartySize2 12
         PartySize3 41
         PartySize4 1000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 52
         PartySize2 21
         PartySize3 30
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 62
         PartySize2 31
         PartySize3 20
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 72
         PartySize2 41
         PartySize3 10
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 82
         PartySize2 51
         PartySize3 0
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 92
         PartySize2 61
         PartySize3 10
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_1_1
   {
      EMPTY
      {
         PartySize1 15
         PartySize2 14
         PartySize3 43
         PartySize4 92
         PartySize5 1021
         PartySize6 1030
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 4
         PartySize2 33
         PartySize3 82
         PartySize4 1031
         PartySize5 1020
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 23
         PartySize2 62
         PartySize3 1041
         PartySize4 1000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 13
         PartySize2 52
         PartySize3 1031
         PartySize4 1010
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 2
         PartySize2 41
         PartySize3 1010
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 12
         PartySize2 31
         PartySize3 1000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 22
         PartySize2 21
         PartySize3 1020
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 31
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 41
         PartySize2 0
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 51
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 61
         PartySize2 20
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 71
         PartySize2 30
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_2
   {
      EMPTY
      {
         PartySize1 25
         PartySize2 4
         PartySize3 33
         PartySize4 82
         PartySize5 1031
         PartySize6 1020
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 14
         PartySize2 23
         PartySize3 72
         PartySize4 1041
         PartySize5 1010
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 13
         PartySize2 52
         PartySize3 1051
         PartySize4 1010
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 23
         PartySize2 62
         PartySize3 1041
         PartySize4 1000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 12
         PartySize2 51
         PartySize3 1020
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 2
         PartySize2 41
         PartySize3 1010
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 12
         PartySize2 31
         PartySize3 1010
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 21
         PartySize2 20
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 31
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 41
         PartySize2 0
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 51
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 61
         PartySize2 20
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_1_1_1
   {
      EMPTY
      {
         PartySize1 34
         PartySize2 13
         PartySize3 22
         PartySize4 71
         PartySize5 1040
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 23
         PartySize2 12
         PartySize3 61
         PartySize4 1030
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 2
         PartySize2 41
         PartySize3 1010
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 12
         PartySize2 51
         PartySize3 1020
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 31
         PartySize2 1000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 21
         PartySize2 1010
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 11
         PartySize2 1030
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 0
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 20
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 30
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 40
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_2_1
   {
      EMPTY
      {
         PartySize1 44
         PartySize2 23
         PartySize3 12
         PartySize4 61
         PartySize5 1030
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 33
         PartySize2 2
         PartySize3 51
         PartySize4 1020
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 12
         PartySize2 31
         PartySize3 1000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 2
         PartySize2 41
         PartySize3 1010
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 21
         PartySize2 1010
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 31
         PartySize2 1000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 21
         PartySize2 1020
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 0
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 20
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 30
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_3
   {
      EMPTY
      {
         PartySize1 54
         PartySize2 33
         PartySize3 2
         PartySize4 51
         PartySize5 1010
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 43
         PartySize2 12
         PartySize3 41
         PartySize4 1000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 22
         PartySize2 21
         PartySize3 1020
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 12
         PartySize2 31
         PartySize3 1010
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 11
         PartySize2 1030
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 21
         PartySize2 1020
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 41
         PartySize2 1000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 30
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 20
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 0
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_1_1_1_1
   {
      EMPTY
      {
         PartySize1 63
         PartySize2 42
         PartySize3 11
         PartySize4 40
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 52
         PartySize2 21
         PartySize3 30
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 31
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 21
         PartySize2 20
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 0
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 30
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_2_1_1
   {
      EMPTY
      {
         PartySize1 73
         PartySize2 52
         PartySize3 21
         PartySize4 30
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 62
         PartySize2 31
         PartySize3 20
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 41
         PartySize2 0
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 31
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 0
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 20
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_2_2
   {
      EMPTY
      {
         PartySize1 83
         PartySize2 62
         PartySize3 31
         PartySize4 20
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 72
         PartySize2 41
         PartySize3 10
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 51
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 41
         PartySize2 0
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 20
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_3_1
   {
      EMPTY
      {
         PartySize1 93
         PartySize2 72
         PartySize3 41
         PartySize4 10
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 82
         PartySize2 51
         PartySize3 0
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 61
         PartySize2 20
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 51
         PartySize2 10
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 30
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 20
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 0
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
   PL_4
   {
      EMPTY
      {
         PartySize1 103
         PartySize2 82
         PartySize3 51
         PartySize4 0
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1
      {
         PartySize1 92
         PartySize2 61
         PartySize3 10
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1
      {
         PartySize1 71
         PartySize2 30
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2
      {
         PartySize1 61
         PartySize2 20
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1
      {
         PartySize1 40
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1
      {
         PartySize1 30
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3
      {
         PartySize1 10
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_1_1_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_1_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_2_2
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_3_1
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
      PL_4
      {
         PartySize1 10000
         PartySize2 10000
         PartySize3 10000
         PartySize4 10000
         PartySize5 10000
         PartySize6 10000
         PartySize7 10000
      }
   }
}
