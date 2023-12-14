"use strict";
/// <reference path="csgo.d.ts" />
var g_movieSoundEventInstanceHandle = null;
function ShowIntroMovie() {
    var movieName = "file://{resources}/videos/intro.webm";
    const launcherType = MyPersonaAPI.GetLauncherType();
    if (launcherType == "perfectworld") {
        movieName = "file://{resources}/videos/intro-perfectworld.webm";
    }
    $("#IntroMoviePlayer").SetMovie(movieName);
    $.Schedule(0.0, PlayIntroMovie);
    $("#IntroMoviePlayer").SetFocus();
    $.RegisterKeyBind($("#IntroMoviePlayer"), "key_enter,key_space,key_escape", SkipIntroMovie);
}
function StopIntroMovieSoundEvent() {
    if (g_movieSoundEventInstanceHandle != null) {
        UiToolkitAPI.StopSoundEvent(g_movieSoundEventInstanceHandle, 0.1);
        g_movieSoundEventInstanceHandle = null;
    }
}
function PlayIntroMovie() {
    StopIntroMovieSoundEvent();
    g_movieSoundEventInstanceHandle = UiToolkitAPI.PlaySoundEvent("UIPanorama.IntroLogo");
    $("#IntroMoviePlayer").Play();
}
function SkipIntroMovie() {
    StopIntroMovieSoundEvent();
    $("#IntroMoviePlayer").Stop();
}
function DestroyMoviePlayer() {
    StopIntroMovieSoundEvent();
    $("#IntroMoviePlayer").SetMovie("");
}
function HideIntroMovie() {
    $.Schedule(0.0, DestroyMoviePlayer);
    $.DispatchEventAsync(0.0, "CSGOHideIntroMovie");
}
(function () {
    $.RegisterForUnhandledEvent("CSGOShowIntroMovie", ShowIntroMovie);
    $.RegisterForUnhandledEvent("CSGOEndIntroMovie", HideIntroMovie);
    $.RegisterEventHandler("MoviePlayerPlaybackEnded", $("#IntroMoviePlayer"), HideIntroMovie);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW50cm9tb3ZpZS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2ludHJvbW92aWUudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUVsQyxJQUFJLCtCQUErQixHQUFrQixJQUFJLENBQUM7QUFFMUQsU0FBUyxjQUFjO0lBRW5CLElBQUksU0FBUyxHQUFHLHNDQUFzQyxDQUFDO0lBQ3ZELE1BQU0sWUFBWSxHQUFHLFlBQVksQ0FBQyxlQUFlLEVBQUUsQ0FBQztJQUNwRCxJQUFLLFlBQVksSUFBSSxjQUFjLEVBQ25DO1FBQ0ksU0FBUyxHQUFHLG1EQUFtRCxDQUFDO0tBQ25FO0lBRUQsQ0FBQyxDQUFXLG1CQUFtQixDQUFFLENBQUMsUUFBUSxDQUFFLFNBQVMsQ0FBRSxDQUFDO0lBS3hELENBQUMsQ0FBQyxRQUFRLENBQUUsR0FBRyxFQUFFLGNBQWMsQ0FBRSxDQUFDO0lBQ2xDLENBQUMsQ0FBVyxtQkFBbUIsQ0FBRSxDQUFDLFFBQVEsRUFBRSxDQUFDO0lBQzdDLENBQUMsQ0FBQyxlQUFlLENBQUUsQ0FBQyxDQUFFLG1CQUFtQixDQUFFLEVBQUUsZ0NBQWdDLEVBQUUsY0FBYyxDQUFFLENBQUM7QUFDcEcsQ0FBQztBQUVELFNBQVMsd0JBQXdCO0lBRTdCLElBQUssK0JBQStCLElBQUksSUFBSSxFQUM1QztRQUNJLFlBQVksQ0FBQyxjQUFjLENBQUUsK0JBQStCLEVBQUUsR0FBRyxDQUFFLENBQUM7UUFDcEUsK0JBQStCLEdBQUcsSUFBSSxDQUFDO0tBQzFDO0FBQ0wsQ0FBQztBQUVELFNBQVMsY0FBYztJQUVuQix3QkFBd0IsRUFBRSxDQUFDO0lBQzNCLCtCQUErQixHQUFHLFlBQVksQ0FBQyxjQUFjLENBQUUsc0JBQXNCLENBQUUsQ0FBQztJQUN4RixDQUFDLENBQVcsbUJBQW1CLENBQUUsQ0FBQyxJQUFJLEVBQUUsQ0FBQztBQUM3QyxDQUFDO0FBRUQsU0FBUyxjQUFjO0lBRW5CLHdCQUF3QixFQUFFLENBQUM7SUFDM0IsQ0FBQyxDQUFXLG1CQUFtQixDQUFFLENBQUMsSUFBSSxFQUFFLENBQUM7QUFDN0MsQ0FBQztBQUVELFNBQVMsa0JBQWtCO0lBRXZCLHdCQUF3QixFQUFFLENBQUM7SUFDM0IsQ0FBQyxDQUFXLG1CQUFtQixDQUFFLENBQUMsUUFBUSxDQUFFLEVBQUUsQ0FBRSxDQUFDO0FBQ3JELENBQUM7QUFFRCxTQUFTLGNBQWM7SUFJbkIsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxHQUFHLEVBQUUsa0JBQWtCLENBQUUsQ0FBQztJQUV0QyxDQUFDLENBQUMsa0JBQWtCLENBQUUsR0FBRyxFQUFFLG9CQUFvQixDQUFFLENBQUM7QUFDdEQsQ0FBQztBQUtELENBQUU7SUFFRSxDQUFDLENBQUMseUJBQXlCLENBQUUsb0JBQW9CLEVBQUUsY0FBYyxDQUFFLENBQUM7SUFDcEUsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLG1CQUFtQixFQUFFLGNBQWMsQ0FBRSxDQUFDO0lBQ25FLENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSwwQkFBMEIsRUFBRSxDQUFDLENBQUUsbUJBQW1CLENBQUUsRUFBRSxjQUFjLENBQUUsQ0FBQztBQUNuRyxDQUFDLENBQUUsRUFBRSxDQUFDIn0=