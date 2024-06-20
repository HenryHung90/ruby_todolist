import {Controller} from '@hotwired/stimulus';

export default class extends Controller {
    connect() {
        console.log("Task controller connected");
        $('#add-tag').on('click', () => {
            const tagsDiv = document.getElementById("tags");
            const newTagDiv = document.createElement("div");
            newTagDiv.className = "tag-fields";
            const newId = new Date().getTime();
            newTagDiv.innerHTML = `
        <label for="task_tags_attributes_${newId}_name">Tag Name</label>
        <input type="text" name="task[tags_attributes][${newId}][name]" id="task_tags_attributes_${newId}_name">
        <input type="checkbox" name="task[tags_attributes][${newId}][_destroy]" id="task_tags_attributes_${newId}__destroy">
        <label for="task_tags_attributes_${newId}__destroy">Remove</label>
      `;
            tagsDiv.appendChild(newTagDiv);
        })
    }
}
