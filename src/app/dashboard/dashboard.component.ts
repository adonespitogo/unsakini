import {Component, OnInit, OnDestroy} from '@angular/core';
import { Router } from '@angular/router';
import {ListService} from '../services/list.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import { CryptoService, ICryptoObservable } from '../services/crypto.service';
import {Subscription} from 'rxjs/Subscription';

@Component({
  templateUrl: './dashboard.html',
  styleUrls: ['./dashboard.scss']
})

export class DashboardComponent implements OnInit, OnDestroy {

  public isCollapsed: boolean = true;
  public sidebarOpen: boolean = false;
  public cryptosubs: Subscription;

  constructor (
    private listService: ListService,
    private router: Router,
    private toaster: ToasterService
  ) {

    this.cryptosubs = CryptoService.validkey$.subscribe((crypto: ICryptoObservable) => {
      if (!crypto.status) {
        router.navigate(['/settings/security']);
        if (!CryptoService.getKey()) {
          this.toaster.pop(
            'error',
            'Set Private Key',
            `Please set your private key first to be able to access your data.`
          );
        } else {
          this.toaster.pop(
            'error',
            'Cryptographic Problem',
            `You might have used a wrong private key.`
          );
        }
      }
    });
  }

  ngOnInit () {
    this.listService.getLists().subscribe(() => {
      this.toaster.clear();
    });
  }

  ngOnDestroy () {
    this.cryptosubs.unsubscribe();
  }

  getLists () {
    return ListService.lists;
  }

}
