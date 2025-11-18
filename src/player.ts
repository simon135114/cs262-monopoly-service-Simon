export interface Player {
    id: number;
    emailaddress: string;   // ✅ 和数据库字段一致
    name: string;
}

export interface PlayerInput {
    emailaddress: string;   // ✅ 和数据库字段一致
    name: string;
}
