import {Component} from "@angular/core";
import {CryptoService} from "../../services/crypto.service";
import {ToasterService} from "angular2-toaster/angular2-toaster";

@Component({
  templateUrl: "./settings.main.html"
})

export class SettingsMainComponent {
  public key;

  constructor (private toaster: ToasterService) {
    this.key = CryptoService.getKey();
  }

  onSubmit () {
    CryptoService.setKey(this.key);
    this.toaster.pop('success', 'Key saved!');
  }
}
