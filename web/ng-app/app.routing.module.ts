
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';


@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: '',
          redirectTo: 'dashboard',
          pathMatch: 'full'
        },
      ],
      {
        useHash: true
      }
    )
  ],
  exports: [
    RouterModule
  ]
})
export class AppRoutingModule {}
