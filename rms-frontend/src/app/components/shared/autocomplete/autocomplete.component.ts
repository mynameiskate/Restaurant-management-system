import { Component, Input, Output, EventEmitter, TemplateRef, OnChanges, OnInit, HostListener, ViewChild } from '@angular/core';
import { IDropdownItem } from '../models/dropdown-item.interface';
import { ControlValueAccessorBase, CreateAccessorProvider } from '../../shared/control-value-accessor/ControlValueAccessorBase';

import * as _ from 'underscore';
import { NgbDropdown } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'clb-autocomplete',
  templateUrl: './autocomplete.component.html',
  providers: [CreateAccessorProvider(AutocompleteComponent)],
  styleUrls: ['./autocomplete.component.less']
})
export class AutocompleteComponent extends ControlValueAccessorBase<number> implements OnChanges, OnInit {
  @Input() label: string;
  @Input() items: IDropdownItem[] = [];
  @Input() itemsPromiseFunction: Function;
  @Input() autocompletePromiseFunction: Function;
  @Input() itemTemplate: TemplateRef<any>;
  @Input() debounceTime = 200;

  @Output() selectionChange = new EventEmitter<number>();

  @ViewChild(NgbDropdown) private dropdown: NgbDropdown;

  searchText: string;
  selectedItem: IDropdownItem;
  autocompleteItems: IDropdownItem[] = [];


  ngOnInit() {
    this.autocompleteOptions = _.debounce(this.autocompleteOptions, this.debounceTime);
  }

  ngOnChanges() {
    this.loadOptions();
  }

  onItemSelect (itemId: number) {
    this.writeValue(itemId);
    this.onChangeCallback(itemId);
    this.selectionChange.emit(itemId);
  }

  writeValue(id: number) {
    if (id) {
      const selectedItem = this.items.find(i => i.id == id);

      if (selectedItem) {
        this.selectedItem = selectedItem;
        this.searchText = selectedItem.value;
      }

      super.writeValue(selectedItem.value);
    }
  }

  openDropdown() {
    this.dropdown.open();
  }

  autocompleteOptions(value: any) {
    if (!value || !value.length) {
      this.autocompleteItems = this.items;
    } else if (!this.autocompletePromiseFunction) {
      this.autocompleteItems = _.filter(this.items,
        (item: IDropdownItem) => (
          item.value.toLowerCase().indexOf(value.toLowerCase()) !== -1)
      );
    } else {
      this.autocompletePromiseFunction(value)
        .then(options => {
          this.autocompleteItems = options;
        });
    }
  }

  private loadOptions() {
    if (this.items && this.items.length || !this.itemsPromiseFunction) {
      return;
    }

    this.itemsPromiseFunction()
      .then(options => {
        this.items = options;
        this.autocompleteItems = options;
      });
  }
}