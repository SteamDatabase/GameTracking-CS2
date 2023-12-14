"use strict";
/// <reference path="csgo.d.ts" />
function GetRankParticleSettings(nRank) {
    let sParticlelevel1 = 'particles/ui/status_levels/ui_status_level_1.vpcf';
    let sParticlelevel2 = 'particles/ui/status_levels/ui_status_level_2.vpcf';
    let sParticlelevel3 = 'particles/ui/status_levels/ui_status_level_3.vpcf';
    let sParticlelevel4 = 'particles/ui/status_levels/ui_status_level_4.vpcf';
    let sParticlelevel5 = 'particles/ui/status_levels/ui_status_level_5.vpcf';
    let sParticlelevel6 = 'particles/ui/status_levels/ui_status_level_6.vpcf';
    let sParticlelevel7 = 'particles/ui/status_levels/ui_status_level_7.vpcf';
    let sParticlelevel8 = 'particles/ui/status_levels/ui_status_level_8.vpcf';
    let aRank = [
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [0, 1, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [1, 1, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [2, 2, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [3, 3, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [4, 4, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [5, 5, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [1, 6, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [2, 7, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [3, 8, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [4, 9, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [5, 10, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [1, 11, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [2, 12, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [3, 13, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [4, 14, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [5, 15, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [1, 16, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [2, 17, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [3, 18, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [4, 19, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [5, 20, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [1, 21, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [2, 22, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [3, 23, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [4, 24, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [5, 25, 1], playEndcap: false },
        { particleName: sParticlelevel6, cpNumber: 3, cpValue: [1, 26, 1], playEndcap: false },
        { particleName: sParticlelevel6, cpNumber: 3, cpValue: [2, 27, 1], playEndcap: false },
        { particleName: sParticlelevel6, cpNumber: 3, cpValue: [3, 28, 1], playEndcap: false },
        { particleName: sParticlelevel6, cpNumber: 3, cpValue: [4, 29, 1], playEndcap: false },
        { particleName: sParticlelevel6, cpNumber: 3, cpValue: [5, 30, 1], playEndcap: false },
        { particleName: sParticlelevel7, cpNumber: 3, cpValue: [1, 31, 1], playEndcap: false },
        { particleName: sParticlelevel7, cpNumber: 3, cpValue: [2, 32, 1], playEndcap: false },
        { particleName: sParticlelevel7, cpNumber: 3, cpValue: [3, 33, 1], playEndcap: false },
        { particleName: sParticlelevel7, cpNumber: 3, cpValue: [4, 34, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [0, 35, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [1, 36, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [2, 37, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [3, 38, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [4, 39, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [5, 40, 1], playEndcap: false },
    ];
    return aRank[nRank];
}
function GetSkillGroupSettings(nSkillGroup, SkillGroupType) {
    let sParticlelevel0 = 'particles/ui/skillgroups/ui_skillgroup_1.vpcf';
    let sParticlelevel1 = 'particles/ui/skillgroups/ui_skillgroup_1.vpcf';
    let sParticlelevel2 = 'particles/ui/skillgroups/ui_skillgroup_2.vpcf';
    let sParticlelevel3 = 'particles/ui/skillgroups/ui_skillgroup_3.vpcf';
    let sParticlelevel4 = 'particles/ui/skillgroups/ui_skillgroup_4.vpcf';
    let sParticlelevel5 = 'particles/ui/skillgroups/ui_skillgroup_5.vpcf';
    let sParticlelevel6 = 'particles/ui/skillgroups/ui_skillgroup_6.vpcf';
    let sParticlelevel7 = 'particles/ui/skillgroups/ui_skillgroup_7.vpcf';
    let sParticlelevel8 = 'particles/ui/skillgroups/ui_skillgroup_8.vpcf';
    let sParticlelevel9 = 'particles/ui/skillgroups/ui_skillgroup_9.vpcf';
    let sParticlelevel10 = 'particles/ui/skillgroups/ui_skillgroup_10.vpcf';
    let sParticlelevel11 = 'particles/ui/skillgroups/ui_skillgroup_11.vpcf';
    let sParticlelevel12 = 'particles/ui/skillgroups/ui_skillgroup_12.vpcf';
    let sParticlelevel13 = 'particles/ui/skillgroups/ui_skillgroup_13.vpcf';
    let sParticlelevel14 = 'particles/ui/skillgroups/ui_skillgroup_14.vpcf';
    let sParticlelevel15 = 'particles/ui/skillgroups/ui_skillgroup_15.vpcf';
    let sParticlelevel16 = 'particles/ui/skillgroups/ui_skillgroup_16.vpcf';
    let sParticlelevel17 = 'particles/ui/skillgroups/ui_skillgroup_17.vpcf';
    let sParticlelevel18 = 'particles/ui/skillgroups/ui_skillgroup_18.vpcf';
    if (SkillGroupType === 'Wingman') {
        sParticlelevel0 = 'particles/ui/skillgroups/ui_skillgroup_wingman_0.vpcf';
        sParticlelevel1 = 'particles/ui/skillgroups/ui_skillgroup_wingman_1.vpcf';
        sParticlelevel2 = 'particles/ui/skillgroups/ui_skillgroup_wingman_2.vpcf';
        sParticlelevel3 = 'particles/ui/skillgroups/ui_skillgroup_wingman_3.vpcf';
        sParticlelevel4 = 'particles/ui/skillgroups/ui_skillgroup_wingman_4.vpcf';
        sParticlelevel5 = 'particles/ui/skillgroups/ui_skillgroup_wingman_5.vpcf';
        sParticlelevel6 = 'particles/ui/skillgroups/ui_skillgroup_wingman_6.vpcf';
        sParticlelevel7 = 'particles/ui/skillgroups/ui_skillgroup_wingman_7.vpcf';
        sParticlelevel8 = 'particles/ui/skillgroups/ui_skillgroup_wingman_8.vpcf';
        sParticlelevel9 = 'particles/ui/skillgroups/ui_skillgroup_wingman_9.vpcf';
        sParticlelevel10 = 'particles/ui/skillgroups/ui_skillgroup_wingman_10.vpcf';
        sParticlelevel11 = 'particles/ui/skillgroups/ui_skillgroup_wingman_11.vpcf';
        sParticlelevel12 = 'particles/ui/skillgroups/ui_skillgroup_wingman_12.vpcf';
        sParticlelevel13 = 'particles/ui/skillgroups/ui_skillgroup_wingman_13.vpcf';
        sParticlelevel14 = 'particles/ui/skillgroups/ui_skillgroup_wingman_14.vpcf';
        sParticlelevel15 = 'particles/ui/skillgroups/ui_skillgroup_wingman_15.vpcf';
        sParticlelevel16 = 'particles/ui/skillgroups/ui_skillgroup_wingman_16.vpcf';
        sParticlelevel17 = 'particles/ui/skillgroups/ui_skillgroup_wingman_17.vpcf';
        sParticlelevel18 = 'particles/ui/skillgroups/ui_skillgroup_wingman_18.vpcf';
    }
    else if (SkillGroupType === 'Premier') {
        sParticlelevel0 = 'particles/dev/empty.vpcf';
        sParticlelevel1 = 'particles/dev/empty.vpcf';
        sParticlelevel2 = 'particles/dev/empty.vpcf';
        sParticlelevel3 = 'particles/dev/empty.vpcf';
        sParticlelevel4 = 'particles/dev/empty.vpcf';
        sParticlelevel5 = 'particles/dev/empty.vpcf';
        sParticlelevel6 = 'particles/dev/empty.vpcf';
        sParticlelevel7 = 'particles/dev/empty.vpcf';
        sParticlelevel8 = 'particles/dev/empty.vpcf';
        sParticlelevel9 = 'particles/dev/empty.vpcf';
        sParticlelevel10 = 'particles/dev/empty.vpcf';
        sParticlelevel11 = 'particles/dev/empty.vpcf';
        sParticlelevel12 = 'particles/dev/empty.vpcf';
        sParticlelevel13 = 'particles/dev/empty.vpcf';
        sParticlelevel14 = 'particles/dev/empty.vpcf';
        sParticlelevel15 = 'particles/dev/empty.vpcf';
        sParticlelevel16 = 'particles/dev/empty.vpcf';
        sParticlelevel17 = 'particles/dev/empty.vpcf';
        sParticlelevel18 = 'particles/dev/empty.vpcf';
    }
    let aSkillGroup = [
        { particleName: sParticlelevel0, cpNumber: 3, cpValue: [1, 0, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [1, 1, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [2, 2, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [3, 3, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [4, 4, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [5, 5, 1], playEndcap: false },
        { particleName: sParticlelevel6, cpNumber: 3, cpValue: [6, 6, 1], playEndcap: false },
        { particleName: sParticlelevel7, cpNumber: 3, cpValue: [7, 7, 1], playEndcap: false },
        { particleName: sParticlelevel8, cpNumber: 3, cpValue: [1, 8, 1], playEndcap: false },
        { particleName: sParticlelevel9, cpNumber: 3, cpValue: [2, 9, 1], playEndcap: false },
        { particleName: sParticlelevel10, cpNumber: 3, cpValue: [3, 10, 1], playEndcap: false },
        { particleName: sParticlelevel11, cpNumber: 3, cpValue: [4, 11, 1], playEndcap: false },
        { particleName: sParticlelevel12, cpNumber: 3, cpValue: [6, 12, 1], playEndcap: false },
        { particleName: sParticlelevel13, cpNumber: 3, cpValue: [6, 13, 1], playEndcap: false },
        { particleName: sParticlelevel14, cpNumber: 3, cpValue: [6, 14, 1], playEndcap: false },
        { particleName: sParticlelevel15, cpNumber: 3, cpValue: [6, 15, 1], playEndcap: false },
        { particleName: sParticlelevel16, cpNumber: 3, cpValue: [6, 16, 1], playEndcap: false },
        { particleName: sParticlelevel17, cpNumber: 3, cpValue: [6, 17, 1], playEndcap: false },
        { particleName: sParticlelevel18, cpNumber: 3, cpValue: [6, 18, 1], playEndcap: false },
        { particleName: sParticlelevel18, cpNumber: 3, cpValue: [6, 19, 1], playEndcap: false },
    ];
    return aSkillGroup[Math.min(nSkillGroup, aSkillGroup.length - 1)];
}
function GetSkillGroupAmbientSettings(nSkillGroup, SkillGroupType) {
    let sParticlelevel0 = 'particles/ui/skillgroups/ui_skillgroup_rear_1.vpcf';
    let sParticlelevel1 = 'particles/ui/skillgroups/ui_skillgroup_rear_1.vpcf';
    let sParticlelevel2 = 'particles/ui/skillgroups/ui_skillgroup_rear_2.vpcf';
    let sParticlelevel3 = 'particles/ui/skillgroups/ui_skillgroup_rear_3.vpcf';
    let sParticlelevel4 = 'particles/ui/skillgroups/ui_skillgroup_rear_4.vpcf';
    let sParticlelevel5 = 'particles/ui/skillgroups/ui_skillgroup_rear_5.vpcf';
    let sParticlelevel6 = 'particles/ui/skillgroups/ui_skillgroup_rear_5.vpcf';
    let sParticlelevel7 = 'particles/ui/skillgroups/ui_skillgroup_rear_5.vpcf';
    let sParticlelevel8 = 'particles/ui/skillgroups/ui_skillgroup_rear_5.vpcf';
    if (SkillGroupType === 'Wingman') {
        sParticlelevel0 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_1.vpcf';
        sParticlelevel1 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_1.vpcf';
        sParticlelevel2 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_2.vpcf';
        sParticlelevel3 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_3.vpcf';
        sParticlelevel4 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_4.vpcf';
        sParticlelevel5 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_5.vpcf';
        sParticlelevel6 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_5.vpcf';
        sParticlelevel7 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_5.vpcf';
        sParticlelevel8 = 'particles/ui/skillgroups/ui_skillgroup_wingman_rear_5.vpcf';
    }
    else if (SkillGroupType === 'Premier') {
        sParticlelevel0 = 'particles/dev/empty.vpcf';
        sParticlelevel1 = 'particles/dev/empty.vpcf';
        sParticlelevel2 = 'particles/dev/empty.vpcf';
        sParticlelevel3 = 'particles/dev/empty.vpcf';
        sParticlelevel4 = 'particles/dev/empty.vpcf';
        sParticlelevel5 = 'particles/dev/empty.vpcf';
        sParticlelevel6 = 'particles/dev/empty.vpcf';
        sParticlelevel7 = 'particles/dev/empty.vpcf';
        sParticlelevel8 = 'particles/dev/empty.vpcf';
    }
    let aSkillGroup = [
        { particleName: sParticlelevel0, cpNumber: 3, cpValue: [1, 0, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [1, 1, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [2, 2, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [3, 3, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [4, 4, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [5, 5, 1], playEndcap: false },
        { particleName: sParticlelevel1, cpNumber: 3, cpValue: [6, 6, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [1, 7, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [2, 8, 1], playEndcap: false },
        { particleName: sParticlelevel2, cpNumber: 3, cpValue: [3, 9, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [4, 10, 1], playEndcap: false },
        { particleName: sParticlelevel3, cpNumber: 3, cpValue: [5, 11, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [1, 12, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [2, 13, 1], playEndcap: false },
        { particleName: sParticlelevel4, cpNumber: 3, cpValue: [3, 14, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [1, 15, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [2, 16, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [6, 17, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [1, 18, 1], playEndcap: false },
        { particleName: sParticlelevel5, cpNumber: 3, cpValue: [2, 19, 1], playEndcap: false },
    ];
    return aSkillGroup[Math.min(nSkillGroup, aSkillGroup.length - 1)];
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicmFua19za2lsbGdyb3VwX3BhcnRpY2xlcy5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3Jhbmtfc2tpbGxncm91cF9wYXJ0aWNsZXMudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQWNsQyxTQUFTLHVCQUF1QixDQUFHLEtBQWE7SUFFNUMsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFDMUUsSUFBSSxlQUFlLEdBQUcsbURBQW1ELENBQUM7SUFFMUUsSUFBSSxLQUFLLEdBQTBCO1FBQy9CLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFHLEVBQUUsVUFBVSxFQUFHLEtBQUssRUFBRztRQUMxRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLENBQUMsQ0FBRyxFQUFFLFVBQVUsRUFBRyxLQUFLLEVBQUc7UUFDMUYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUcsRUFBRSxVQUFVLEVBQUcsS0FBSyxFQUFHO1FBQzFGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFHLEVBQUUsVUFBVSxFQUFHLEtBQUssRUFBRztRQUMxRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLENBQUMsQ0FBRyxFQUFFLFVBQVUsRUFBRyxLQUFLLEVBQUc7UUFDMUYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUcsRUFBRSxVQUFVLEVBQUcsS0FBSyxFQUFHO1FBRTFGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFHLEVBQUUsVUFBVSxFQUFHLEtBQUssRUFBRztRQUMxRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLENBQUMsQ0FBRyxFQUFFLFVBQVUsRUFBRyxLQUFLLEVBQUc7UUFDMUYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUcsRUFBRSxVQUFVLEVBQUcsS0FBSyxFQUFHO1FBQzFGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFHLEVBQUUsVUFBVSxFQUFHLEtBQUssRUFBRztRQUMxRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFFeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUV4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBRXhGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFFeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUV4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFFeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDeEYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3hGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFFLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN4RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBRSxPQUFPLEVB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QWdCLEdBQUcsMEJBQTBCLENBQUM7UUFDOUMsZ0JBQWdCLEdBQUcsMEJBQTBCLENBQUM7UUFDOUMsZ0JBQWdCLEdBQUcsMEJBQTBCLENBQUM7UUFDOUMsZ0JBQWdCLEdBQUcsMEJBQTBCLENBQUM7UUFDOUMsZ0JBQWdCLEdBQUcsMEJBQTBCLENBQUM7UUFDOUMsZ0JBQWdCLEdBQUcsMEJBQTBCLENBQUM7S0FDakQ7SUFHRCxJQUFJLFdBQVcsR0FBMEI7UUFDckMsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUMsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFDLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUNyRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLENBQUMsQ0FBQyxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDckYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUMsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFDLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUNyRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLENBQUMsQ0FBQyxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDckYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUMsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBRSxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUUsQ0FBQyxDQUFDLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUVyRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUUsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLENBQUMsQ0FBQyxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFDckYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFFLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLENBQUMsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBRXJGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBRXJGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBQ3JGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBRXJGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBRXJGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO1FBRXJGLEVBQUUsWUFBWSxFQUFFLGdCQUFnQixFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUUsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUMsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFDO0tBQ3hGLENBQUM7SUFDRixPQUFPLFdBQVcsQ0FBRSxJQUFJLENBQUMsR0FBRyxDQUFDLFdBQVcsRUFBRyxX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LENBQUUsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFHO1FBRXRGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBQyxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxDQUFDLEVBQUcsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRztRQUN2RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUMsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsQ0FBQyxFQUFHLENBQUMsQ0FBRSxFQUFFLFVBQVUsRUFBRSxLQUFLLEVBQUc7UUFDdkYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRyxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFHO1FBQ3ZGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBQyxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN0RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUMsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFDLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFFckYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3RGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBQyxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUUsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUN0RixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUMsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFDLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFFckYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBQ3RGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBQyxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUMsVUFBVSxFQUFFLEtBQUssRUFBRTtRQUVyRixFQUFFLFlBQVksRUFBRSxlQUFlLEVBQUMsUUFBUSxFQUFFLENBQUMsRUFBQyxPQUFPLEVBQUUsQ0FBRSxDQUFDLEVBQUUsRUFBRSxFQUFFLENBQUMsQ0FBRSxFQUFDLFVBQVUsRUFBRSxLQUFLLEVBQUU7UUFFckYsRUFBRSxZQUFZLEVBQUUsZUFBZSxFQUFDLFFBQVEsRUFBRSxDQUFDLEVBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQyxFQUFFLEVBQUUsRUFBRSxDQUFDLENBQUUsRUFBQyxVQUFVLEVBQUUsS0FBSyxFQUFFO1FBRXJGLEVBQUUsWUFBWSxFQUFFLGVBQWUsRUFBQyxRQUFRLEVBQUUsQ0FBQyxFQUFDLE9BQU8sRUFBRSxDQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsQ0FBQyxDQUFFLEVBQUMsVUFBVSxFQUFFLEtBQUssRUFBRTtLQUN4RixDQUFDO0lBR0YsT0FBTyxXQUFXLENBQUUsSUFBSSxDQUFDLEdBQUcsQ0FBQyxXQUFXLEVBQUcsV0FBVyxDQUFDLE1BQU0sR0FBRyxDQUFDLENBQUMsQ0FBRSxDQUFDO0FBQ3pFLENBQUMifQ==