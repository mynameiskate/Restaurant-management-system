import { Component, ElementRef, Input, ViewChild } from '@angular/core';
import { ControlValueAccessorBase, CreateAccessorProvider } from "../control-value-accessor/ControlValueAccessorBase";

@Component({
  selector: 'clb-editable',
  templateUrl: './content-editable.component.html',
  providers: [CreateAccessorProvider(ContentEditableComponent)]
})
export class ContentEditableComponent extends ControlValueAccessorBase<string> {
  @Input() maxLength: number = 25;
  @ViewChild('element') element: ElementRef;

  searchText: string;

  updateValue() {
    this.searchText = this.element.nativeElement.innerText;
    this.onChangeCallback(this.element.nativeElement.innerText);
  }

  limitLength(event: any) {
    const key = event.key;

    if (key === 'Backspace' || key === 'Delete') {
      return;
    } else if (this.element.nativeElement.innerText.length >= this.maxLength) {
      event.preventDefault();
    }
  }

  writeValue(value: string) {
    if (!(this.maxLength && value && value.length < this.maxLength)) {
      return;
    }
    this.element.nativeElement.innerText = value;
    this.searchText = value;
    super.writeValue(value);
  }
}
