<template>
  <el-dialog v-model="dialogVisible" title="选择文件" width="500">
    <div class="dialog-content">
      <el-upload
        ref="upload"
        class="upload-demo"
        action="#"
        :limit="1"
        :on-exceed="handleExceed"
        :auto-upload="true"
        :http-request="httpRequest"
        accept=".json"
      >
        <template #trigger>
          <el-button type="primary">select file</el-button>
        </template>
      </el-upload>
    </div>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="isLoading" @click="submit">
          确定
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import {
  genFileId,
  type UploadInstance,
  type UploadProps,
  type UploadRawFile,
  type UploadRequestOptions
} from "element-plus";
import { computed, ref } from "vue";
import type { EchartsData } from "../utils";

interface Props {
  modelValue: boolean;
}
interface Emits {
  (e: "update:modelValue", value: boolean): void;
  (e: "setData", value: EchartsData[]): void;
}
const props = defineProps<Props>();
const emits = defineEmits<Emits>();
const dialogVisible = computed({
  get: () => props.modelValue,
  set: value => {
    emits("update:modelValue", value);
  }
});
let currentFile: File | null = null;
const upload = ref<UploadInstance>();

const handleExceed: UploadProps["onExceed"] = files => {
  upload.value!.clearFiles();
  const file = files[0] as UploadRawFile;
  currentFile = file;
  file.uid = genFileId();
  upload.value!.handleStart(file);
};
const httpRequest = (options: UploadRequestOptions) => {
  currentFile = options.file;
  return Promise.resolve();
};
const isLoading = ref(false);
const submit = () => {
  // 获取上传文件
  if (!currentFile) {
    ElMessage.error("请选择文件");
    return;
  }
  isLoading.value = true;
  const reader = new FileReader();
  reader.readAsText(currentFile);
  reader.onload = () => {
    const result = reader.result;
    emits("setData", JSON.parse(result as string) as EchartsData[]);
    isLoading.value = false;
    dialogVisible.value = false;
  };
};
</script>
