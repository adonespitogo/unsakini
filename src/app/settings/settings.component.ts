import {Component} from '@angular/core';


@Component({
  templateUrl: './settings.html',
  styleUrls: ['./settings.component.scss']
})


export class SettingsComponent {
  public isCollapsed: boolean = true;
  public sidebarOpen: boolean = false;

}
